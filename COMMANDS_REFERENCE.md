# Commands Reference

This document shows all the commands used to set up and use claude-code-agents.

## Initial Setup (One-time per project)

### 1. Add Submodule to Your Project

```bash
# Navigate to your project
cd /path/to/your-project

# Add claude-code-agents as a submodule
git submodule add https://github.com/TitanlordCode/claude-code-agents .claude-agents

# Run the installer (copies agents to .claude/commands/)
bash .claude-agents/install.sh

# Stage and commit the submodule
git add .gitmodules .claude-agents
git commit -m "feat: Add claude-code-agents submodule"
```

### 2. What the Installer Does

The `install.sh` script:
- Creates `.claude/commands/` directory
- Copies `review.md`, `test.md`, `pre-commit.md` to `.claude/commands/`
- Adds `.claude/` to `.gitignore` (keeps agents local only)
- Shows available slash commands

## Using the Agents

### /review - Code Review

```bash
# Make some changes
git add .

# Run review in Claude Code
/review
```

**First run behavior**:
1. Detects your project (e.g., "Vue 3 + TypeScript + Vite")
2. Checks for `.claude-agents/agents/tech-specific/review-javascript-vue.md`
3. If not found, creates it by analyzing your project
4. Uses the guidelines for the review

**Subsequent runs**:
1. Loads existing tech-specific file
2. Runs review using those guidelines
3. Offers to refine based on new learnings

### /test - Write Tests

```bash
# Run testing agent
/test
```

Creates `test-{language}-{framework}.md` on first run.

### /pre-commit - Quality Checks

```bash
# Before committing
/pre-commit
```

Creates `precommit-{language}-{framework}.md` on first run.

## Updating the Agents

### Update to Latest Version

```bash
cd /path/to/your-project

# Pull latest changes from claude-code-agents
git submodule update --remote .claude-agents

# Re-run installer (preserves your tech-specific files)
bash .claude-agents/update.sh

# Commit the updated submodule reference
git add .claude-agents
git commit -m "chore: Update claude-code-agents to latest version"
```

## Managing Tech-Specific Files

### Where Tech-Specific Files Live

```
your-project/
├── .claude-agents/                    # Git submodule (this repo)
│   ├── agents/
│   │   ├── review.md                  # Universal orchestrator
│   │   ├── test.md                    # Universal orchestrator
│   │   ├── pre-commit.md              # Universal orchestrator
│   │   └── tech-specific/             # Shared knowledge base
│   │       ├── review-javascript-vue.md      # ✅ COMMIT THIS
│   │       ├── test-python-django.md         # ✅ COMMIT THIS
│   │       └── precommit-go.md               # ✅ COMMIT THIS
└── .claude/                           # Local only (gitignored)
    ├── commands/                      # Copied from submodule
    │   ├── review.md
    │   ├── test.md
    │   └── pre-commit.md
    └── review-guidelines.md           # ❌ DO NOT commit (project-specific)
```

### Committing Tech-Specific Files (Sharing Knowledge)

If you want to share the tech-specific guidelines with other projects using the same stack:

```bash
# Navigate to the submodule
cd .claude-agents

# Check what files were created
git status

# Add the universal guidelines (remove project-specific details first!)
git add agents/tech-specific/review-javascript-vue.md

# Commit to the submodule
git commit -m "feat: Add Vue 3 + TypeScript + Vite review guidelines"

# Push to your fork of claude-code-agents
git push origin main

# Submit a PR to share with the community!
```

### Creating Project-Specific Guidelines

For conventions unique to your project (like "Neo" prefix), create:

`.claude/review-guidelines.md`:
```markdown
# NeoMateria Project-Specific Guidelines

## Naming Conventions
- All components use `Neo` prefix (e.g., `NeoButton`)
- Types in separate `*Types.ts` files

## Color System
- Use `material-colors` package
- Apply colors via `Themed` class utility

## Component Structure
- Atomic Design: `01-atoms/`, `02-molecules/`, `03-organisms/`
- Co-locate styles: `Component-themed.css` and `Component-layout.css`
```

The review agent will **automatically load both**:
1. Universal guidelines from `.claude-agents/agents/tech-specific/`
2. Project-specific guidelines from `.claude/review-guidelines.md`

## Team Workflow

### Developer A (First Time Setup)

```bash
git clone your-repo
cd your-repo

# Initialize submodule
git submodule update --init

# Install agents locally
bash .claude-agents/install.sh

# Use agents
/review
```

### Developer B (Joining Later)

```bash
git clone your-repo
cd your-repo

# Submodule auto-initializes
git submodule update --init

# Install agents
bash .claude-agents/install.sh

# Tech-specific files already exist in submodule!
/review  # Uses existing review-javascript-vue.md instantly
```

### When Stack Changes (e.g., Add Python)

```bash
# First developer to work on Python code runs:
/review  # On Python files

# Agent auto-creates: .claude-agents/agents/tech-specific/review-python.md

# Developer commits it to submodule:
cd .claude-agents
git add agents/tech-specific/review-python.md
git commit -m "feat: Add Python review guidelines"
git push

# Update main project:
cd ..
git add .claude-agents
git commit -m "chore: Update submodule with Python guidelines"

# Other devs get it automatically:
git pull
git submodule update --remote .claude-agents
```

## Advanced: Forking the Agents

If you want to customize the universal agents themselves:

```bash
# 1. Fork https://github.com/TitanlordCode/claude-code-agents on GitHub

# 2. In your project, update the submodule URL
git config -f .gitmodules submodule..claude-agents.url https://github.com/YOUR_USERNAME/claude-code-agents.git

# 3. Sync the changes
git submodule sync
git submodule update --init --remote

# 4. Make changes directly in .claude-agents/
cd .claude-agents
git checkout -b my-custom-agents
# ...edit agents/review.md...
git commit -m "feat: Customize review agent"
git push origin my-custom-agents

# 5. Update main project to use your fork
cd ..
git add .claude-agents
git commit -m "chore: Use forked claude-code-agents"
```

## Troubleshooting

### "Submodule not initialized"

```bash
git submodule update --init
```

### "Changes not staged" for submodule

```bash
cd .claude-agents
git status  # See what changed
git add .   # If you want to keep changes
git commit -m "Update tech-specific guidelines"
cd ..
git add .claude-agents  # Update submodule reference
```

### "Permission denied" on install.sh

```bash
chmod +x .claude-agents/install.sh
bash .claude-agents/install.sh
```

### Tech-specific file has project details

Edit the file to remove project-specific content before committing:
```bash
cd .claude-agents
# Edit agents/tech-specific/review-javascript-vue.md
# Remove lines like "Neo prefix", "material-colors", etc.
git add agents/tech-specific/review-javascript-vue.md
git commit -m "refactor: Make Vue guidelines more universal"
```

## npm Integration (JavaScript/TypeScript Projects)

Add to your `package.json`:

```json
{
  "scripts": {
    "postinstall": "git submodule update --init && bash .claude-agents/install.sh",
    "agents:update": "git submodule update --remote .claude-agents && bash .claude-agents/update.sh"
  }
}
```

Now:
- `npm install` automatically sets up agents
- `npm run agents:update` pulls latest agent improvements
