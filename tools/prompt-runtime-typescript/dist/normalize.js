export function normalizeText(input) {
    if (!input.trim())
        return "";
    const withoutAccents = input
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "")
        .replace(/[\u0111\u0110]/g, "d")
        .toLowerCase();
    return withoutAccents.replace(/[^a-z0-9]+/g, " ").trim();
}
