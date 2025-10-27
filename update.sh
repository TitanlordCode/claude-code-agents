#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Determine project root (parent of submodule if running from .claude-agents or .agents)
if [[ "$SCRIPT_DIR" == *"/.claude-agents"* ]] || [[ "$SCRIPT_DIR" == *"\\.claude-agents"* ]] || \
   [[ "$SCRIPT_DIR" == *"/.agents"* ]] || [[ "$SCRIPT_DIR" == *"\\.agents"* ]]; then
    # Running from submodule - go to parent directory
    PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
    # Get the actual submodule directory name
    SUBMODULE_DIR="$(basename "$SCRIPT_DIR")"
else
    # Running from source repo - use current directory
    PROJECT_ROOT="$PWD"
    SUBMODULE_DIR=".claude-agents"
fi

CLAUDE_DIR="$PROJECT_ROOT/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
CACHE_DIR="$SCRIPT_DIR/.cache"

echo "🔄 Updating Claude Code Agents..."
echo ""

# Check if .claude/commands exists
if [ ! -d "$COMMANDS_DIR" ]; then
    echo "⚠️  .claude/commands/ not found. Running install instead..."
    exec "$SCRIPT_DIR/install.sh"
fi

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"
mkdir -p "$CACHE_DIR/context"

# Re-copy agents (overwrites local .claude/)
echo "Updating agents..."
cp "$SCRIPT_DIR/agents/review.md" "$COMMANDS_DIR/review.md"
cp "$SCRIPT_DIR/agents/test.md" "$COMMANDS_DIR/test.md"
cp "$SCRIPT_DIR/agents/pre-commit.md" "$COMMANDS_DIR/pre-commit.md"

echo ""
echo "✅ Claude Code Agents updated to latest version!"
echo ""
echo "📝 Note: Project-specific files in .claude/ were preserved:"
echo "   - review-guidelines.md (if exists)"
echo "   - testing-guidelines.md (if exists)"
echo "   - pre-commit-checklist.md (if exists)"
echo ""
