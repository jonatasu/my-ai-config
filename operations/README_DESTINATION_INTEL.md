# Destination Intelligence (Twenty + Bubba)

This module adds destination/prospect intelligence on top of Twenty DB.

## Files
- `destination_intel_manager.py`
- `bubba_destinations.sh`
- audit: `/opt/ops/destination_intel_audit.ndjson`

## Commands
- `init-schema`
- `ingest-daily-trends [--limit-per-feed 12]`
- `destination-rank [--limit 20]`
- `list-sources [--limit 50]`
- `upsert-client-profile --client-key ... --full-name ... --birth-date YYYY-MM-DD --social-urls ... --preferences-json ...`
- `record-client-request --client-key ... --destination-name ... [--source-url ...] [--context ...]`
- `suggest-birthday [--days-ahead 150] [--window-days 7] [--top-n 5]`

## Cron suggestion (08:00)

Production note:
- run the scout inside the `hermes` container so it can use the same mounted runtime/config context as the other Bubba operations.

```
0 8 * * * /usr/bin/docker exec hermes python3 /opt/ops/destination_intel_manager.py ingest-daily-trends --limit-per-feed 12 >> /var/log/ft-destination-scout.log 2>&1
```

## Data model
- `ft_intel.source_registry`
- `ft_intel.destination_catalog`
- `ft_intel.destination_source`
- `ft_intel.destination_signal`
- `ft_intel.client_profile`
- `ft_intel.client_destination_affinity`
- `ft_intel.recommendation_snapshot`
- view: `ft_intel.destination_rank`
