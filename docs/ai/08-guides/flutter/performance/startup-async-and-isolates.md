# Startup Async And Isolates Pack

## Use For

- cold start
- startup sequencing
- background work
- `compute` and isolate decisions

## Default Decisions

- keep startup on the critical path minimal
- defer nonessential work until after first useful frame
- move CPU-heavy parsing or transformation off the main isolate
- prefer simple async sequencing before introducing isolate complexity

## Decision Switches

- if first frame is slow, remove or defer synchronous startup work first
- if heavy CPU work repeats or blocks animation, isolate offloading is justified
- if work is tiny or infrequent, isolate overhead may not pay off
