#!/bin/bash
set -e

CLAUDE_DIR=".claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
CACHE_DIR=".claude-agents/.cache"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
if [ -f ".gitignore" ]; then
    if ! grep -q "^\.claude/$" .gitignore 2>/dev/null; then
        echo "" >> .gitignore
        echo "# Claude Code - local development only" >> .gitignore
        echo ".claude/" >> .gitignore
        echo "✓ Added .claude/ to .gitignore"
    fi
else
    echo "# Claude Code - local development only" > .gitignore
    echo ".claude/" >> .gitignore
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
