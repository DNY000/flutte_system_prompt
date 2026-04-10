#!/bin/bash

# Flutter Prompt OS - Prompt Bundler
# This script merges core rules into a single ingestion-ready file.

OUTPUT_FILE="FPOS_MASTER_BUNDLE.md"

echo "# FLUTTER PROMPT OS: MASTER BUNDLE" > $OUTPUT_FILE
echo "Generated on: $(date)" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 1. MANUAL INGESTION PROMPT" >> $OUTPUT_FILE
cat manual-prompt-bundle.md >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 2. CANONICAL SYSTEM PROMPT" >> $OUTPUT_FILE
cat docs/ai/core/system/system-prompt.md >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 3. COMPACT RULES" >> $OUTPUT_FILE
cat docs/ai/core/system/runtime-rules-compact.md >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 4. OUTPUT RULES" >> $OUTPUT_FILE
cat docs/ai/core/contracts/output-rules.md >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 5. STRUCTURED OUTPUT SCHEMAS" >> $OUTPUT_FILE
cat docs/ai/core/contracts/structured-output-schemas.json >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "BUNDLE COMPLETE: $OUTPUT_FILE"
