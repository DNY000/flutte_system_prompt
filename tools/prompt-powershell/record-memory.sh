#!/bin/bash
# record-memory.sh - Automatically append structured resolved issues to mistakes.md
# Usage: ./record-memory.sh <path_to_resolved_issue_markdown_file>

if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_resolved_issue_markdown_file>"
  exit 1
fi

INPUT_FILE="$1"
MEMORY_FILE="../../docs/ai/memory/mistakes.md"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: Input file '$INPUT_FILE' not found."
  exit 1
fi

# Ensure the memory directory and file exist
mkdir -p "$(dirname "$MEMORY_FILE")"
touch "$MEMORY_FILE"

echo -e "\n\n---\n" >> "$MEMORY_FILE"
cat "$INPUT_FILE" >> "$MEMORY_FILE"

echo "✅ Successfully recorded issue to $MEMORY_FILE"
