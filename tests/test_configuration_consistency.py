#!/usr/bin/env python3

import json
import re
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[1]


def load_yaml(path: str) -> dict:
    value = yaml.safe_load((ROOT / path).read_text(encoding="utf-8"))
    assert isinstance(value, dict), path
    return value


def validate(instance, schema, path="$") -> None:
    expected_type = schema.get("type")
    type_matches = {
        "object": isinstance(instance, dict),
        "array": isinstance(instance, list),
        "string": isinstance(instance, str),
        "integer": isinstance(instance, int) and not isinstance(instance, bool),
        "boolean": isinstance(instance, bool),
    }
    if expected_type and not type_matches[expected_type]:
        raise AssertionError(f"{path}: expected {expected_type}")
    if "const" in schema and instance != schema["const"]:
        raise AssertionError(f"{path}: expected {schema['const']!r}")
    if isinstance(instance, str):
        if len(instance) < schema.get("minLength", 0):
            raise AssertionError(f"{path}: string is too short")
        if "pattern" in schema and not re.search(schema["pattern"], instance):
            raise AssertionError(f"{path}: string does not match pattern")
    if isinstance(instance, list):
        if len(instance) < schema.get("minItems", 0):
            raise AssertionError(f"{path}: too few items")
        for index, item in enumerate(instance):
            validate(item, schema["items"], f"{path}[{index}]")
    if isinstance(instance, dict):
        if len(instance) < schema.get("minProperties", 0):
            raise AssertionError(f"{path}: too few properties")
        for required in schema.get("required", []):
            if required not in instance:
                raise AssertionError(f"{path}: missing {required}")
        for key, child_schema in schema.get("properties", {}).items():
            if key in instance:
                validate(instance[key], child_schema, f"{path}.{key}")


def check_manifest_references(manifest: dict) -> None:
    path_fields = {
        "architecture", "mindset", "system_prompt", "principles", "orchestration",
        "index", "directory", "registry", "catalog", "adapters", "contract",
        "adapter", "permissions", "verification", "manifest", "host_templates",
        "provider_examples",
    }

    def visit(value, key: str = ""):
        if isinstance(value, dict):
            for child_key, child_value in value.items():
                visit(child_value, child_key)
        elif isinstance(value, list):
            for item in value:
                visit(item, key)
        elif isinstance(value, str) and key in path_fields:
            assert (ROOT / value).exists(), value

    visit(manifest)


def main() -> None:
    manifest = load_yaml("agentic.config.yaml")
    manifest_schema = json.loads((ROOT / "schemas/agentic.config.schema.json").read_text())
    validate(manifest, manifest_schema)
    check_manifest_references(manifest)

    registry = load_yaml("agents/registry.yaml")
    assert registry["version"] == 1
    assert registry["agents"]
    agent_ids = {agent["id"] for agent in registry["agents"]}
    assert "tars" in agent_ids
    assert "orchestrator" not in agent_ids
    required_agent_fields = {
        "id",
        "role",
        "scope",
        "required_context",
        "allowed_tools",
        "deliverable",
        "escalation",
    }
    for agent in registry["agents"]:
        assert required_agent_fields <= agent.keys(), agent["id"]

    permissions = load_yaml("policies/permissions.yaml")
    assert permissions["defaults"]["persist_secrets"] is False
    assert permissions["defaults"]["destructive_actions"] == "deny"
    assert permissions["capabilities"]["external_writes"]["approval_required"] is True

    verification = load_yaml("verification/default.yaml")
    assert verification["completion"]["require_acceptance_criteria"] is True
    assert verification["completion"]["require_current_evidence"] is True
    assert verification["completion"]["require_independent_review"] is True
    assert verification["completion"]["allow_open_findings"] is False

    schema_pairs = (
        ("agentic.config.schema.json", manifest),
        ("agents.registry.schema.json", registry),
        ("permissions.schema.json", permissions),
        ("verification.schema.json", verification),
    )
    for schema, configuration in schema_pairs:
        schema_value = json.loads((ROOT / "schemas" / schema).read_text())
        assert schema_value["$schema"].startswith("https://json-schema.org/")
        assert schema_value["type"] == "object"
        validate(configuration, schema_value, schema)

    laya_caveman = load_yaml("adapters/providers/laya-caveman.yaml")
    assert laya_caveman["decision_policy"]["unavailable_result"] == "BLOCK"
    assert laya_caveman["decision_policy"]["abstained_result"] == "REVIEW"
    assert laya_caveman["evidence"]["compression"]["stage"] == "post_decision"
    assert laya_caveman["evidence"]["compression"]["final_user_output"] == "normal_language"

    architecture_doc = ROOT / "docs/AGENTIC-ENVIRONMENT.md"
    assert architecture_doc.exists()
    assert manifest["core"]["architecture"] == str(architecture_doc.relative_to(ROOT))
    for skill in (
        "generate-feature-map.md",
        "guardrail-audit.md",
        "subagent-briefs.md",
        "session-lifecycle.md",
        "verification-ledger.md",
        "adversarial-review.md",
        "skill-lifecycle.md",
        "capability-mapping.md",
        "codebase-context.md",
    ):
        assert (ROOT / ".core/skills" / skill).exists(), skill

    for host in ("opencode", "hermes-agent", "github-copilot", "claude-code"):
        assert (ROOT / "docs/hosts" / f"{host}.md").exists(), host
        adapter = load_yaml(f"adapters/hosts/{host}.yaml")
        assert adapter["portable_mapping"]["loading"][0] == "docs/AGENTIC-ENVIRONMENT.md"
        assert adapter["portable_mapping"]["orchestrator"] == "tars"
        assert adapter["policy"]["writes"] == "approval_required"
        assert adapter["policy"]["git_add"] == "approval_required"
        assert adapter["policy"]["git_commit"] == "approval_required"
        assert adapter["policy"]["secrets_persistence"] == "denied"

    opencode_adapter = load_yaml("adapters/hosts/opencode.yaml")
    repomix_command = opencode_adapter["mcp_servers"]["repomix"]["command"]
    assert "--mcp" in repomix_command
    assert "--sandbox" in repomix_command
    copilot_adapter = load_yaml("adapters/hosts/github-copilot.yaml")
    assert copilot_adapter["portable_mapping"]["loading"] == [
        "docs/AGENTIC-ENVIRONMENT.md",
        "agentic.config.yaml",
        "docs/hosts/github-copilot.md",
        ".core/system_prompt.txt",
        ".core/skills/index.md",
        "docs/GRILL-LAYA-CAVEMAN-WORKFLOW.md",
        "agents/registry.yaml",
    ]
    for path in copilot_adapter["portable_mapping"]["loading"]:
        assert (ROOT / path).exists(), path
    assert copilot_adapter["portable_mapping"]["orchestrator"] == "tars"
    required_copilot_skills = {
        ".core/skills/generate-feature-map.md",
        ".core/skills/guardrail-audit.md",
        ".core/skills/closed-loop.md",
        ".core/skills/verification-ledger.md",
    }
    assert required_copilot_skills <= set(copilot_adapter["portable_mapping"]["skills"])
    for path in copilot_adapter["portable_mapping"]["skills"]:
        assert (ROOT / path).exists(), path
    assert copilot_adapter["portable_mapping"]["host_skill_bridges"] == [
        "~/.copilot/skills/agentic-config/SKILL.md",
        "~/.copilot/skills/generate-feature-map/SKILL.md",
        "~/.copilot/skills/guardrail-audit/SKILL.md",
    ]
    repomix = copilot_adapter["mcp_servers"]["repomix"]
    assert repomix["transport"] == "local"
    assert "--mcp" in repomix["command"]
    assert "--sandbox" in repomix["command"]
    assert repomix["remote_repository_packing"] == "disabled"
    assert copilot_adapter["policy"]["writes"] == "approval_required"
    assert copilot_adapter["policy"]["secrets_persistence"] == "denied"
    assert copilot_adapter["policy"]["git_add"] == "approval_required"
    assert copilot_adapter["policy"]["git_commit"] == "approval_required"
    assert not (Path.home() / ".config/opencode/agents/orchestrator.md").exists()
    for path in (
        ROOT / "docs/AGENTS-SOULS-AND-PERSONALITIES.md",
        ROOT / ".core/agents/hermes/SOUL.md",
    ):
        text = path.read_text(encoding="utf-8").lower()
        assert "hermes (interface & orchestration)" not in text
        assert "primary orchestrator" not in text
        assert "hermes (interface & orchestrator)" not in text

    print("configuration schema and conformance validation passed")


if __name__ == "__main__":
    main()
