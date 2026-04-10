#!/bin/bash

# ==========================================
# 🎯 FPOS - Flutter Prompt OS Installer
# ==========================================

echo "🚀 Starting Flutter Prompt OS (FPOS) Installation..."

# Check if it's a Flutter project
if [ ! -f "pubspec.yaml" ]; then
    echo "⚠️ Warning: pubspec.yaml not found. Make sure you are running this in the root of your Flutter project."
fi

TMP_DIR=$(mktemp -d)
echo "📥 Downloading FPOS architectural standards..."

# Use curl to fetch the zip directly, WITHOUT using git. Completely avoids tracking metadata.
curl -fsSL "https://github.com/DNY000/flutter_prompts/archive/refs/heads/main.zip" -o "$TMP_DIR/fpos.zip"

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to download the package from GitHub. Please check your internet connection."
    rm -rf "$TMP_DIR"
    exit 1
fi

echo "📦 Extracting and installing core components..."
unzip -q "$TMP_DIR/fpos.zip" -d "$TMP_DIR"

# Create destination directory if not exists
mkdir -p .cursor

# Extract and inject the core files into the current project
cp -r "$TMP_DIR/flutter_prompts-main/.cursor/rules" ./.cursor/ 2>/dev/null
cp -r "$TMP_DIR/flutter_prompts-main/docs" . 2>/dev/null
cp -f "$TMP_DIR/flutter_prompts-main/MASTER_PROMPT.md" . 2>/dev/null

# Clean up
rm -rf "$TMP_DIR"

echo "✅ FPOS Installation Complete!"
echo "👉 For Cursor IDE users: The rules have been embedded into .cursor/rules/prompt-os-always-on.mdc. (Please reload your window to apply)"
echo "👉 For other Web AI tools: Please copy the configuration from MASTER_PROMPT.md."
