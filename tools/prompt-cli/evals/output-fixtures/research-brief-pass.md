## Question
Which source should the team trust first for current Flutter web renderer guidance?

## Sources
- https://docs.flutter.dev/platform-integration/web/renderers
- https://docs.flutter.dev/deployment/web

## Facts
- Flutter documents renderer behavior in the official web renderer guide.
- Deployment constraints are documented separately in the official web deployment guide.

## Comparison
- Official renderer guide: strongest source for renderer capabilities and defaults.
- Official deployment guide: strongest source for hosting and build delivery decisions.

## Recommendation
Use the official renderer guide first, then use deployment docs for hosting-specific decisions.

## Risks
- Renderer defaults can change across stable releases, so version-sensitive decisions still need a date check.
