/**
 * Builds the effective skill activation list: unique `skill_id`s ordered by
 * precedence — project first, then global additions, then built-in route skills.
 * Same as policy: project > global > built-in for ordering; duplicates keep first position.
 */
export function resolveSkillsByPrecedence(input) {
    const builtIn = input.builtInSkills ?? input.route.skills;
    const global = input.globalSkills ?? [];
    const project = input.projectSkills ?? [];
    const seen = new Set();
    const ordered = [];
    function appendSkills(skillIds) {
        for (const skillId of skillIds) {
            if (seen.has(skillId))
                continue;
            seen.add(skillId);
            ordered.push(skillId);
        }
    }
    appendSkills(project);
    appendSkills(global);
    appendSkills(builtIn);
    return ordered;
}
