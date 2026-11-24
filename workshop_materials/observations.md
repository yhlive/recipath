# Shopping session performance observations

## Run setup

- Fixture: 240 grocery rows and 60 quick-shopping rows
- Device and run mode:
- VS Code and DevTools versions:
- Window size:
- Search and scroll sequence:
- Enhanced tracing enabled:
- CPU sampling rate and duration:

## CPU and frame evidence

| Measurement | Before | After |
| --- | --- | --- |
| Dart CLI matches per run | | |
| Three Dart CLI elapsed values (microseconds) | | |
| Median Dart CLI elapsed value | | |
| Dart CPU samples | | |
| Hot functions or callers | | |
| Flutter UI time for the comparable action | | |
| Flutter raster time for the comparable action | | |
| Trace or screenshot filenames | | |

The Dart CLI covers the shared search functions. The Flutter timeline covers the app and renderer on the selected device. Keep those measurements separate.

## Memory comparison

- Start and finish screen, fixture size, and window size:
- Number of shopping → groceries → shopping loops:
- Time to settle before each snapshot:
- Garbage collected before both snapshots:
- Evidence filename:

| Class or metric | Snapshot A | Snapshot B | Difference or retaining reference |
| --- | --- | --- | --- |
| TextEditingController | | | |
| ShoppingScreen or its state | | | |
| Dart heap used | | | |
| Other class under investigation | | | |

## What changed

Describe the matching behavior, the observed path in the profile, and any result that varied between runs.
