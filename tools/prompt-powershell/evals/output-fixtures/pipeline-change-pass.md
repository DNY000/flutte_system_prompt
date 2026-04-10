## Summary
Split Android release into build, validate, and rollout stages with rollback support.

## Current State
One GitHub Actions job builds and uploads the Android artifact without staged validation.

## Target Pipeline
1. Build signed Android artifact.
2. Run smoke tests and artifact validation.
3. Upload to internal testing track.
4. Promote to production after approval.

## Validation Steps
1. Verify signing inputs resolve from protected secrets.
2. Confirm smoke tests pass on the release flavor.
3. Confirm mapping files and release notes are archived.

## Secrets And Environments
Use protected release secrets, one staging environment, and one production promotion boundary.

## Rollback
Pause promotion and redeploy the previous signed artifact from the last green release.

## Risks
Promotion automation can ship the wrong flavor if branch-to-environment mapping drifts.
