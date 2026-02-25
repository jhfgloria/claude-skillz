#!/bin/bash

# Script to install Claude Code skills from a Git repository by copying them
# Usage: ./install-claude-skills.sh <path-to-skills-repo> [--force]

set -e

SKILLS_REPO_PATH="$1"
FORCE_INSTALL=false
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"

# Check for --force flag
if [[ "$2" == "--force" ]] || [[ "$1" == "--force" && -n "$2" ]]; then
    FORCE_INSTALL=true
    if [[ "$1" == "--force" ]]; then
        SKILLS_REPO_PATH="$2"
    fi
fi

# Validate input
if [[ -z "$SKILLS_REPO_PATH" ]]; then
    echo "Usage: $0 <path-to-skills-repo> [--force]"
    echo ""
    echo "Options:"
    echo "  --force    Remove existing skills before installing"
    echo ""
    echo "Example: $0 ~/repos/my-claude-skills"
    exit 1
fi

# Expand path and check if it exists
SKILLS_REPO_PATH=$(eval echo "$SKILLS_REPO_PATH")
if [[ ! -d "$SKILLS_REPO_PATH" ]]; then
    echo "Error: Directory not found: $SKILLS_REPO_PATH"
    exit 1
fi

# Create Claude skills directory if it doesn't exist
mkdir -p "$CLAUDE_SKILLS_DIR"

echo "Installing Claude Code skills from: $SKILLS_REPO_PATH"
echo "Target directory: $CLAUDE_SKILLS_DIR"
echo ""

# Counter for installed skills
INSTALLED_COUNT=0
SKIPPED_COUNT=0
UPDATED_COUNT=0

# Iterate through each subdirectory in the skills repo
shopt -s nullglob
for skill_path in "$SKILLS_REPO_PATH"/*/; do
    # Remove trailing slash
    skill_path="${skill_path%/}"
    
    # Skip if not a directory
    if [[ ! -d "$skill_path" ]]; then
        continue
    fi

    skill_name=$(basename "$skill_path")
    target_path="$CLAUDE_SKILLS_DIR/$skill_name"

    # Check if target already exists
    if [[ -e "$target_path" ]]; then
        if [[ "$FORCE_INSTALL" == true ]]; then
            echo "  [UPDATE] Removing existing: $skill_name"
            rm -rf "$target_path"
            cp -r "$skill_path" "$target_path"
            echo "  [✓] Updated: $skill_name"
            ((UPDATED_COUNT++)) || true
        else
            echo "  [SKIP] Already exists: $skill_name"
            echo "         Use --force to replace"
            ((SKIPPED_COUNT++)) || true
        fi
    else
        # Copy the skill directory
        cp -r "$skill_path" "$target_path"
        echo "  [✓] Installed: $skill_name"
        ((INSTALLED_COUNT++)) || true
    fi
done

echo ""
echo "Summary:"
echo "  - Installed: $INSTALLED_COUNT"
echo "  - Updated: $UPDATED_COUNT"
echo "  - Skipped: $SKIPPED_COUNT"
echo ""

if [[ $SKIPPED_COUNT -gt 0 ]] && [[ "$FORCE_INSTALL" == false ]]; then
    echo "Tip: Run with --force to update existing skills"
fi

echo "Done! Your skills are now available in Claude Code."
