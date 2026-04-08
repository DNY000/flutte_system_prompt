export function normalizeText(input: string): string {
  if (!input.trim()) return "";
  const withoutAccents = input
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase();
  return withoutAccents.replace(/[^a-z0-9]+/g, " ").trim();
}
