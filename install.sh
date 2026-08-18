#!/usr/bin/env bash
# λambda installer — copies the skills into ~/.claude/skills and scaffolds a vault.
# Usage: ./install.sh [vault-dir]   (default vault: ~/lambda-vault)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="${HOME}/.claude/skills"
VAULT_DIR="${1:-${HOME}/lambda-vault}"

echo "λambda install"
echo "  skills → ${SKILLS_DIR}"
mkdir -p "${SKILLS_DIR}"
cp -R "${REPO_DIR}/skills/lambda" "${SKILLS_DIR}/"
cp -R "${REPO_DIR}/skills/lambda-map" "${SKILLS_DIR}/"

if [ -d "${VAULT_DIR}/mind" ]; then
  echo "  vault  → ${VAULT_DIR} (exists, left untouched)"
else
  echo "  vault  → ${VAULT_DIR} (scaffolding)"
  mkdir -p "${VAULT_DIR}"
  cp -R "${REPO_DIR}/vault-template/." "${VAULT_DIR}/"
fi

cat <<EOF

Done.

Next:
  1. Open ${VAULT_DIR} as a vault in Obsidian (or any markdown renderer).
  2. Build a course map from your own materials:
       cd ${VAULT_DIR} && claude
       /lambda-map <course-name> <folder with question PDFs>
  3. Run a session:
       /lambda <lecture or topic>

The skills load in new Claude Code sessions. Run them on a frontier-tier
model — the skill will refuse weaker ones.
EOF
