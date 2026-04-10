#!/bin/bash
# scan-secrets.sh - A pre-commit hook template to scan staged files for secrets.
# You can symlink this file to .git/hooks/pre-commit
# Example: ln -s ../../tools/prompt-powershell/scan-secrets.sh .git/hooks/pre-commit

echo "ðŸ•µï¸  Scanning staged files for leaked secrets..."

# Regex patterns for common secrets
JWT_PATTERN="eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}"
STRIPE_PATTERN="(sk_live|rk_live)_[0-9a-zA-Z]{24,}"
GOOGLE_API_PATTERN="AIza[0-9A-Za-z-_]{35}"
GENERIC_BEARER="Bearer [A-Za-z0-9\-\._~\+\/]+="

# Get list of staged files
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM)

if [ -z "$STAGED_FILES" ]; then
    exit 0
fi

LEAK_FOUND=0

for FILE in $STAGED_FILES; do
    # Search for patterns
    if git show ":$FILE" | grep -qE "$JWT_PATTERN|$STRIPE_PATTERN|$GOOGLE_API_PATTERN|$GENERIC_BEARER"; then
        echo "ðŸš¨ ERROR: Potential Secret Leaked in $FILE"
        echo "   Please replace it with [REDACTED_SECRET] or remove it before committing."
        LEAK_FOUND=1
    fi
done

if [ $LEAK_FOUND -eq 1 ]; then
    echo "âŒ Commit aborted due to secret leaking risks. (Check runtime-rules.md - Security Auditor Mandate)"
    exit 1
fi

echo "âœ… No hardcoded secrets found!"
exit 0
