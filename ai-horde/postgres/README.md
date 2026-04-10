# Postgres w/ pg_cron for AI-Horde

Supported PostgreSQL versions:
- PostgreSQL 14
- PostgreSQL 15
- PostgreSQL 16
- PostgreSQL 17
- PostgreSQL 18

All versions include:
- pg_cron (built from source via multi-stage build)

## Tags

- `pg14`, `pg15`, `pg16`, `pg17`, `pg18` — specific PostgreSQL major versions
- `latest` — tracks PostgreSQL 18

## Freshness

Upstream `postgres` base digests are checked weekly via the `freshness.yml` workflow.
When one or more versions change, the workflow opens a PR that updates `upstream-digests.lock.json`.
Merging that PR triggers the publish workflow so artifact refreshes are explicit and reviewable.