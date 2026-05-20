import os
import sys
import argparse

SKILLS_ROOT = "/Users/jonatas.vieira.ext/Github_repos/my-ai-config/.core/skills/"

# Mapping of aliases to skill names/filenames
ALIASES = {
    "architecture": "architecture",
    "coding": "coding",
}

def find_skill(skill_query):
    # Resolve alias
    target = ALIASES.get(skill_query.lower(), skill_query.lower())
    
    # 1. Check for direct .md files in SKILLS_ROOT
    direct_file = os.path.join(SKILLS_ROOT, f"{target}.md")
    if os.path.exists(direct_file):
        return direct_file
    
    # 2. Check for directories named target containing SKILL.md
    skill_dir = os.path.join(SKILLS_ROOT, target)
    if os.path.isdir(skill_dir):
        skill_md = os.path.join(skill_dir, "SKILL.md")
        if os.path.exists(skill_md):
            return skill_md
            
    # 3. Recursive search for the target string in filenames
    for root, dirs, files in os.walk(SKILLS_ROOT):
        for file in files:
            if file.startswith(target) and file.endswith(".md"):
                return os.path.join(root, file)
                
    return None

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Map skill name to file path")
    parser.add_argument("skill", help="The name of the skill to resolve")
    args = parser.parse_args()
    
    result = find_skill(args.skill)
    if result:
        print(result)
        sys.exit(0)
    else:
        print(f"Skill '{args.skill}' not found.", file=sys.stderr)
        sys.exit(1)
