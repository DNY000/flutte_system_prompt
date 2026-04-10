#!/bin/bash

# Flutter Prompt OS - Prompt Bundler
# This script merges core rules into a single ingestion-ready file.

OUTPUT_FILE="FPOS_MASTER_BUNDLE.md"

echo "# FLUTTER PROMPT OS: MASTER BUNDLE" > $OUTPUT_FILE
echo "Generated on: $(date)" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 1. MASTER PROMPT" >> $OUTPUT_FILE
cat MASTER_PROMPT.md >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 2. CORE RULES" >> $OUTPUT_FILE
cat docs/ai/00-core/system/rules.md >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 3. ARCHITECTURE MANDATES" >> $OUTPUT_FILE
cat docs/ai/08-guides/flutter/app-architecture/layering-and-dependencies.md >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "BUNDLE COMPLETE: $OUTPUT_FILE"
