# Claude Code Agents

**Universal, self-learning development agents for code review, testing, and quality checks.**

Adaptive AI agents that work with any programming language or project type. From JavaScript to Rust, from web apps to Blender add-ons, these agents learn your project's patterns and provide intelligent assistance.

📖 **[View Complete Commands Reference](COMMANDS_REFERENCE.md)** - Detailed workflow and examples

## Features

### 🔍 Adaptive Code Review (`/review`)
- **Language-agnostic**: JavaScript/TypeScript, Python, Go, Rust, PHP, Java, C#, Ruby, C/C++, and more
- **Framework-aware**: Automatically detects Vue, React, Angular, Django, Rails, etc.
- **Self-learning**: Offers to create project-specific guidelines after the first review
- **Domain-specific**: Understands web apps, CLIs, data pipelines, game development, infrastructure

### 🧪 Universal Testing (`/test`)
- **Multi-framework**: Vitest, Jest, pytest, Go testing, cargo test, PHPUnit, JUnit, xUnit, RSpec
- **Pattern-aware**: Learns from existing tests and follows project conventions
- **Comprehensive**: Unit, integration, E2E, accessibility, performance testing
- **Example-driven**: Provides language-specific test examples and best practices

### ✅ Pre-commit Checks (`/pre-commit`)
- **Quality gates**: Runs formatters, linters, type checkers, tests, and builds
- **Auto-fix**: Identifies and fixes auto-correctable issues
- **CI alignment**: Mirrors your CI/CD checks locally
- **Fast feedback**: Catch issues before they reach code review

## Supported Languages & Ecosystems

**Programming Languages:**
- JavaScript/TypeScript (Node.js, Deno, Bun)
- Python (Django, Flask, FastAPI, Data Science)
- Go (CLI tools, microservices)
- Rust (systems programming, WebAssembly)
- PHP (Laravel, Symfony)
- Java (Spring, Maven, Gradle)
- C# (.NET, ASP.NET)
- Ruby (Rails, Sinatra)
- C/C++ (CMake, Make)
- And more...

**Creative & Specialized:**
- Blender add-ons (Python)
- Unity/Unreal/Godot (game development)
- Jupyter notebooks (data science)
- Terraform/Ansible (infrastructure)
- Docker/Kubernetes (containers)

## Installation

### Quick Start

Add to your project as a git submodule:

```bash
# Add the agents repository
git submodule add https://github.com/TitanlordCode/claude-code-agents .claude-agents

# Run the installer
.claude-agents/install.sh

# Commit the submodule reference
git add .gitmodules .claude-agents .gitignore
git commit -m "Add Claude Code Agents"
```

The installer will:
- Create `.claude/commands/` with the three agents
- Add `.claude/` to your `.gitignore` (keeps it local only)
- Display available commands

### Team Setup

When teammates clone your project:

```bash
# Clone and initialize submodule
git clone <your-project>
git submodule update --init

# Install agents locally
.claude-agents/install.sh
```

### Optional: npm Integration

For JavaScript/TypeScript projects, add to `package.json`:

```json
{
  "scripts": {
    "postinstall": "git submodule update --init && .claude-agents/install.sh",
    "agents:update": "git submodule update --remote .claude-agents && .claude-agents/update.sh"
  }
}
```

Now `npm install` automatically sets up the agents!

## Usage

Once installed, you'll have three slash commands available:

### `/review` - Code Review
Reviews all staged changes with language-specific expertise:

```bash
# Make some changes
git add .

# Run review
/review
```

The agent will:
1. Detect your project type (e.g., "Vue 3 + TypeScript")
2. Review changes using framework-specific best practices
3. Check tests, linting, type safety, security, performance
4. Offer to create `.claude/review-guidelines.md` for future consistency

### `/test` - Write Tests
Generates comprehensive tests for any code:

```bash
# Run testing agent
/test
```

The agent will:
1. Detect your testing framework (pytest, Jest, Go test, etc.)
2. Analyze the code to understand what needs testing
3. Write idiomatic tests following project patterns
4. Run the tests and fix any failures
5. Offer to create `.claude/testing-guidelines.md`

### `/pre-commit` - Quality Checks
Runs all configured quality tools before committing:

```bash
# Before committing
/pre-commit
```

The agent will:
1. Discover your quality tools (linters, formatters, tests)
2. Run all checks (formatting, linting, type checking, tests, build)
3. Offer to auto-fix issues where possible
4. Report status and next steps
5. Offer to create `.claude/pre-commit-checklist.md`

## Self-Learning Behavior

After the first run in a new project, agents offer to create project-specific guidelines:

**`.claude/review-guidelines.md`** - Your project's code standards
**`.claude/testing-guidelines.md`** - Your testing patterns and conventions
**`.claude/pre-commit-checklist.md`** - Your quality gate checklist

These files:
- Are gitignored (local only, can be committed if desired)
- Make future runs more consistent and project-aware
- Can be manually edited to capture team preferences
- Help onboard new contributors

## Context Persistence

Agents remember your previous conversations and maintain context across sessions:

**`.claude-agents/.cache/context/`** - Conversation history
- `review-last.json` - Last review session
- `test-last.json` - Last testing session
- `precommit-last.json` - Last pre-commit session

**Benefits**:
- **Continuity**: Pick up where you left off
- **Preferences**: Remember your choices (auto-fix, verbosity, etc.)
- **Pending items**: Track unresolved issues across sessions
- **Insights**: Accumulate project knowledge over time
- **Efficiency**: Avoid repeating same analysis

**Example**:
```
📋 Previous session (2 hours ago):
- Reviewed 3 files in src/components/
- Fixed 2/3 issues (1 pending)
- Pending: Fix type error in Button.vue:45

Continuing from where we left off...
```

**Privacy**: Context stored locally only, not committed to git, contains no sensitive data.

## MCP Recommendations

Agents can recommend relevant MCP servers to enhance your workflow based on your project type.

### How It Works

On first run in a new project, agents detect your stack and suggest useful MCPs:

**Example for Vue + TypeScript + PostgreSQL**:
```
🔌 Recommended MCPs for your project:

Essential:
✓ filesystem - Enhanced file operations
✓ git - Advanced git operations

Highly Recommended:
📦 brave-search - Search npm packages and docs
🗄️ postgres - Database operations and queries
🐙 github - PR and issue management

Optional:
🎭 puppeteer - E2E testing automation

Would you like help setting these up?
```

### Supported MCPs

**Development Tools**:
- `filesystem` - Enhanced file operations
- `git` - Advanced git features
- `github` - PR management, issues, repository operations

**Language-Specific**:
- `brave-search` - Package discovery, documentation
- `postgres` / `sqlite` - Database operations
- `puppeteer` - Browser automation, E2E testing

**Framework-Specific**:
- Recommendations based on Vue, React, Django, Rails, etc.

### Installation Help

Agents provide:
- Configuration snippets for `claude_desktop_config.json`
- Installation commands
- Environment variable requirements
- Usage hints after installation

**Safety**: Agents never auto-install MCPs - they always ask permission and explain what each MCP does.

## Updating

To get the latest agents:

```bash
# Update submodule to latest
git submodule update --remote .claude-agents

# Re-run installer (preserves your project-specific files)
.claude-agents/update.sh

# Or use npm script if configured
npm run agents:update
```

## Privacy & Publishing

The `.claude/` directory is automatically gitignored, so:
- Your project-specific guidelines stay private
- The actual agent commands are local only
- Published npm packages don't include `.claude/`

Only the submodule reference (`.gitmodules`) is visible, which simply points to this public repository.

## Self-Bootstrapping Architecture

These agents use a **self-bootstrapping** mechanism that makes them smarter with each use:

### How It Works

**First Run (Vue 3 + TypeScript project):**
1. Agent detects: JavaScript + Vue 3
2. Checks for: `.claude-agents/agents/tech-specific/review-javascript-vue.md`
3. Not found → Creates it by analyzing your project:
   - Reads `package.json`, configuration files
   - Examines 2-3 component files
   - Documents patterns, conventions, tools
4. Uses newly created guidelines for this review
5. Future runs: Loads existing guidelines instantly

### Tech-Specific Knowledge Files

Agents automatically create and maintain:
- `.claude-agents/agents/tech-specific/review-{lang}-{framework}.md`
- `.claude-agents/agents/tech-specific/test-{lang}-{framework}.md`
- `.claude-agents/agents/tech-specific/precommit-{lang}-{framework}.md`

These files contain **universal patterns** for each stack:
- Language/framework best practices
- Common tools and configurations
- Typical project structures
- Automated check commands
- Code examples and anti-patterns

**Important**: These files should contain **universal knowledge** (e.g., "Vue 3 best practices") that can be shared across projects. For project-specific conventions (e.g., "Neo prefix", "Material colors"), create `.claude/review-guidelines.md` in your project instead.

### Benefits

✅ **Zero configuration** - Works immediately out of the box
✅ **Self-improving** - Learns your patterns automatically
✅ **Consistent** - Same rules applied every time
✅ **Shareable** - Commit tech-specific files to share with team
✅ **Evolvable** - Agents offer to refine guidelines after each run

### Directory Structure

```
your-project/
├── .claude-agents/          # Git submodule (this repo)
│   ├── agents/
│   │   ├── review.md        # Universal orchestrator
│   │   ├── test.md          # Universal orchestrator
│   │   ├── pre-commit.md    # Universal orchestrator
│   │   └── tech-specific/   # Auto-generated knowledge base
│   │       ├── review-javascript-vue.md      # Created on first review
│   │       ├── test-javascript-vue.md        # Created on first test run
│   │       ├── precommit-javascript-vue.md   # Created on first pre-commit
│   │       └── .gitkeep
│   ├── install.sh
│   └── update.sh
├── .claude/                 # Created by installer (gitignored)
│   ├── commands/            # Agent commands (copied from submodule)
│   │   ├── review.md
│   │   ├── test.md
│   │   └── pre-commit.md
│   ├── review-guidelines.md      # User-maintained (optional)
│   ├── testing-guidelines.md     # User-maintained (optional)
│   └── pre-commit-checklist.md   # User-maintained (optional)
└── .gitignore               # Contains .claude/
```

## Requirements

- **Claude Code** by Anthropic (recommended) or compatible AI coding assistant
- Git 2.13+ (for submodules)
- Bash shell (for install/update scripts)

## About Claude Code

These agents are designed for use with **[Claude Code](https://claude.ai/claude-code)**, Anthropic's official AI coding assistant.

**Important:**
- Claude Code and Claude AI are proprietary technologies owned by **Anthropic, PBC**
- All rights to Claude Code, Claude AI models, and related technologies belong to Anthropic
- This project provides workflow configurations/prompts for use with Claude Code
- You must have access to Claude Code or a compatible AI assistant to use these agents

## Contributing

Contributions welcome! These agents are designed to be:
- Language-agnostic
- Framework-aware
- Self-improving
- Community-driven

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License & Attribution

**This Project (claude-code-agents):**
- MIT License - Copyright (c) 2025 TitanlordCode (https://github.com/TitanlordCode)
- See [LICENSE](LICENSE) for full license text
- You are free to use, modify, and distribute this project under the MIT License

**Claude Code & Claude AI:**
- Copyright © 2025 Anthropic, PBC. All rights reserved.
- Claude Code is a trademark of Anthropic, PBC
- Visit https://claude.ai for terms of service and usage policies

**Disclaimer:**
This is an independent, open-source project that provides configuration files for Claude Code. It is not affiliated with, officially endorsed by, or supported by Anthropic, PBC. Use of Claude Code is subject to Anthropic's terms of service.
