# Better Group Sports (BGS)

Simple, fair league management for adult recreation sports — web and mobile.

## Planning docs

- [BUILD_PLAN.md](BUILD_PLAN.md) — architecture, phasing, and locked-in build decisions
- [SPORTS_ROADMAP.md](SPORTS_ROADMAP.md) — full long-term sport support list
- [League_Platform_Pricing_Model.md](League_Platform_Pricing_Model.md) — monetization model
- [CHANGELOG.md](CHANGELOG.md) — running log of features/changes as they land

## Repo structure

This is a single Dart workspace (`pubspec.yaml` at root) containing:

| Package | Role |
|---|---|
| `bgs_server` | Serverpod backend (Dart, Postgres) |
| `bgs_client` | Generated Serverpod client — typed API bindings shared by `bgs_flutter` and `bgs_web` |
| `bgs_flutter` | Flutter app — iOS, Android, and authenticated web dashboards |
| `bgs_web` | Jaspr server-rendered public site — org homepages, event links, search (SEO-facing pages) |

## Getting started

```bash
dart pub get
```

resolves the whole workspace at once. Then, per package:

**Backend** (`bgs_server`) — requires Docker for local Postgres:
```bash
cd bgs_server
docker compose up --build --detach
dart bin/main.dart --apply-migrations
```
Local dev ports are non-default (18080 api / 18081 insights / 18082 web / 18090 postgres / 18091 redis, 19090/19091 for the test DB/redis) because this machine already runs another project on Serverpod's default 8080-9091 range. See `bgs_server/docker-compose.yaml` and `bgs_server/config/*.yaml` if that changes.

**Flutter app** (`bgs_flutter`):
```bash
cd bgs_flutter
flutter run
```

**Public site** (`bgs_web`):
```bash
cd bgs_web
jaspr serve
```
Runs on port 18180 (set in `bgs_web/pubspec.yaml`) for the same reason — default 8080 collides with the other local project.
