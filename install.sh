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

echo "📦 Installing Claude Code Agents..."
echo ""

# Create .claude structure (not tracked by git)
mkdir -p "$COMMANDS_DIR"

# Create cache directory for performance optimization
mkdir -p "$CACHE_DIR"
mkdir -p "$CACHE_DIR/context"
echo "✓ Created cache directory for performance optimization"
echo "✓ Created context directory for conversation persistence"

# Copy agents to .claude/commands/
echo "Copying agents..."
cp "$SCRIPT_DIR/agents/review.md" "$COMMANDS_DIR/review.md"
cp "$SCRIPT_DIR/agents/test.md" "$COMMANDS_DIR/test.md"
cp "$SCRIPT_DIR/agents/pre-commit.md" "$COMMANDS_DIR/pre-commit.md"

# Ensure .claude is in gitignore
GITIGNORE_FILE="$PROJECT_ROOT/.gitignore"
if [ -f "$GITIGNORE_FILE" ]; then
    if ! grep -q "^\.claude/$" "$GITIGNORE_FILE" 2>/dev/null; then
        echo "" >> "$GITIGNORE_FILE"
        echo "# Claude Code - local development only" >> "$GITIGNORE_FILE"
        echo ".claude/" >> "$GITIGNORE_FILE"
        echo "✓ Added .claude/ to .gitignore"
    fi
else
    echo "# Claude Code - local development only" > "$GITIGNORE_FILE"
    echo ".claude/" >> "$GITIGNORE_FILE"
    echo "✓ Created .gitignore with .claude/"
fi

echo ""
echo "✅ Claude Code Agents installed successfully!"
echo ""
echo "Available commands:"
echo "  /review      - Adaptive code review agent (works with any language)"
echo "  /test        - Universal testing agent (Go, Python, Rust, JS/TS, etc.)"
echo "  /pre-commit  - Multi-language pre-commit quality checks"
echo ""
echo "📝 Note: .claude/ is gitignored and stays local only"
echo "🔄 To update: git submodule update --remote .claude-agents && .claude-agents/install.sh"
echo ""
