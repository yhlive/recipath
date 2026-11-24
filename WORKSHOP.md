# ReciPath Shopping Session Workshop

Upstream: https://github.com/Cunibon/recipath
Pinned upstream commit: a54ef17d2067ba81aa8bf3bcf0148c54800cc61f
Flutter SDK: 3.50.1

## Run configurations

Open this project directory in VS Code and use **Run and Debug**.

| Configuration | Purpose |
| --- | --- |
| ReciPath Demo \| Debug | Six deterministic rows in the real shopping screen. |
| ReciPath Stress \| macOS Profile | Native Flutter timeline and heap work with 300 rows. |
| ReciPath Stress \| Debug | Stress fixture on the selected Android emulator or desktop device. |
| ReciPath Android \| Offline | Upstream offline entry for a normal application smoke check. |
| ReciPath Search \| Dart CPU | Local Dart CPU workload using the application's search functions. |

The workshop uses in-memory SQLite and temporary settings. Restart the app to reset the fixture. The CLI workload runs on localhost for DevTools. Its `--once` switch reports the deterministic match count and observed elapsed time.

The accompanying Chinese HTML guide contains the runbook, exact code anchors, and profiling steps. Your GitHub fork is the destination for workshop commits. The upstream project is MIT-licensed. See LICENSE for attribution.
