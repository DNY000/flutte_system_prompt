## Summary
Translate the loyalty feature requirements into a mobile-first Flutter design handoff for first release.

## User Story
As a loyalty member, I want to review my points balance and redemption eligibility so I can decide whether to redeem now.

## Acceptance Criteria (AC)
- User can see current points balance and loyalty tier on first load.
- User can tell whether redemption is currently available.
- User can review recent activity and open redemption from a clear primary CTA.

## Extracted UI States
- Loading balance and recent activity skeletons
- Empty activity history with guidance on how to earn points
- Error state with inline retry while preserving loyalty context
- Redemption locked state with eligibility explanation
- Offline cached view with stale-data indicator

## Non-functional UX Constraints
- Keep the balance and redemption CTA visible within the first mobile viewport.
- Announce points balance and eligibility as accessible semantic content.
- Track loyalty overview open, redemption CTA tap, and redemption blocked reasons.
