# MCP Recommendation System

Agents can recommend and help install relevant MCP servers based on project type.

## MCP Registry

### Development Tools

**@modelcontextprotocol/server-filesystem**
- **Use case**: File system access for any project
- **When**: Always useful
- **Why**: Enhanced file operations, search, and navigation
- **Install**: `npx -y @modelcontextprotocol/create-server filesystem`

**@modelcontextprotocol/server-github**
- **Use case**: GitHub integration
- **When**: Project has `.git` and GitHub remote
- **Why**: PR management, issue tracking, repository operations
- **Install**: Requires GitHub token
- **Config**: `gh auth login` first

**@modelcontextprotocol/server-git**
- **Use case**: Git operations
- **When**: Project has `.git` directory
- **Why**: Advanced git operations, history analysis
- **Install**: `npx -y @modelcontextprotocol/create-server git`

### Language-Specific MCPs

**JavaScript/TypeScript Projects**

**@modelcontextprotocol/server-brave-search**
- **Use case**: Search npm packages, documentation
- **When**: `package.json` exists
- **Why**: Find packages, check compatibility, read docs
- **Install**: Requires Brave Search API key

**@modelcontextprotocol/server-postgres** / **sqlite**
- **Use case**: Database projects
- **When**: Database config files detected
- **Why**: Query analysis, schema management
- **Install**: Requires database connection

**Python Projects**

**@modelcontextprotocol/server-postgres** / **sqlite**
- **Use case**: Django, Flask, FastAPI projects
- **When**: `requirements.txt` or `pyproject.toml` with DB libs
- **Why**: Database operations, migrations

**@modelcontextprotocol/server-brave-search**
- **Use case**: Find Python packages, documentation
- **When**: `pyproject.toml` exists
- **Why**: Package discovery, API documentation

### Framework-Specific MCPs

**Web Development**

**@modelcontextprotocol/server-puppeteer**
- **Use case**: E2E testing, automation
- **When**: Vue, React, Angular projects
- **Why**: Browser automation, screenshot testing
- **Install**: `npx -y @modelcontextprotocol/create-server puppeteer`

**@modelcontextprotocol/server-brave-search**
- **Use case**: Web development research
- **When**: Frontend frameworks detected
- **Why**: MDN docs, browser compatibility, CSS tricks

**Data Science**

**@modelcontextprotocol/server-sqlite**
- **Use case**: Data analysis
- **When**: Jupyter notebooks, pandas detected
- **Why**: Data querying, exploration

**Infrastructure**

**@modelcontextprotocol/server-aws-kb-retrieval**
- **Use case**: AWS deployments
- **When**: AWS configs detected (serverless.yml, CDK, etc.)
- **Why**: AWS documentation, best practices

## Detection Logic

### Check Project Type
1. Read package manager files
2. Scan for framework indicators
3. Check for database configs
4. Look for CI/CD configs
5. Identify deployment targets

### Recommend MCPs
Based on detected stack, suggest 2-4 most relevant MCPs:

**Priority Levels**:
- **Essential**: Almost always needed (filesystem, git)
- **Highly Recommended**: Strong match to project type
- **Optional**: Nice to have, depends on workflow

### Example Recommendations

**Vue 3 + TypeScript + Supabase Project**:
```
🔌 Recommended MCPs for your project:

Essential:
✓ filesystem - Enhanced file operations
✓ git - Advanced git operations

Highly Recommended:
📦 brave-search - Search npm packages and docs
🗄️ postgres - Supabase database operations
🐙 github - PR and issue management

Optional:
🎭 puppeteer - E2E testing automation

Would you like help setting these up?
```

## Installation Helper

### Step 1: Check Existing MCPs
Read: `~/.config/claude/claude_desktop_config.json` (macOS/Linux)
Or: `%APPDATA%/Claude/claude_desktop_config.json` (Windows)

### Step 2: Recommend Missing MCPs
Compare detected project needs vs installed MCPs.

### Step 3: Provide Installation Commands
For each recommended MCP:
```bash
# Add to claude_desktop_config.json:
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/project"]
    }
  }
}
```

### Step 4: Offer Auto-Configuration
Ask: "Would you like me to add these to your Claude Desktop config?"

If yes:
1. Read existing config
2. Merge new MCPs
3. Write updated config
4. Remind to restart Claude Desktop

## MCP Usage Hints

After installation, provide usage hints:

**filesystem MCP**:
> "You can now use advanced file search and operations.
> Try: 'Search for all Vue components with props validation'"

**github MCP**:
> "You can now create PRs and manage issues.
> Try: 'Create a PR for these changes'"

**postgres MCP**:
> "You can now query your database directly.
> Try: 'Show me the schema for the users table'"

## Safety & Privacy

**Never Auto-Install MCPs**:
- Always ask permission
- Explain what each MCP does
- Show configuration before writing

**API Keys**:
- Don't ask for API keys
- Provide documentation links
- Let user configure separately

**Permissions**:
- Explain MCP access levels
- Note filesystem paths
- Warn about database access

## When to Recommend MCPs

**On First Run** (after project detection):
> "I detected this is a {stack} project. Would you like MCP recommendations to enhance your workflow?"

**When Relevant** (during review/testing):
> "I notice you're working with a database. The postgres MCP could help with schema analysis. Want to learn more?"

**Never Spam**:
- Recommend once per project
- Store preference in context
- Respect "no" answers

## Configuration Format

### Claude Desktop Config
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-name", "arg1", "arg2"],
      "env": {
        "API_KEY": "optional"
      }
    }
  }
}
```

### Common Patterns

**Node-based MCP**:
```json
{
  "server-name": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-name"]
  }
}
```

**With environment variables**:
```json
{
  "brave-search": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-brave-search"],
    "env": {
      "BRAVE_API_KEY": "your-key-here"
    }
  }
}
```

**With path arguments**:
```json
{
  "filesystem": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/allowed/directory"]
  }
}
```

## Example Integration

In agent workflow (after project detection):

```
Detected: Vue 3 + TypeScript + PostgreSQL

🔌 MCP Recommendations:
- filesystem: Enhanced file operations ✓ Installed
- git: Advanced git features ✗ Not installed
- postgres: Database operations ✗ Not installed
- github: PR management ✓ Installed

Missing 2 recommended MCPs. Would you like installation help?
```

User says yes:

```
I can add these to your Claude Desktop config:

1. Git MCP
   {
     "git": {
       "command": "npx",
       "args": ["-y", "@modelcontextprotocol/server-git"]
     }
   }

2. PostgreSQL MCP
   {
     "postgres": {
       "command": "npx",
       "args": ["-y", "@modelcontextprotocol/server-postgres"],
       "env": {
         "POSTGRES_CONNECTION": "postgresql://localhost/mydb"
       }
     }
   }
   Note: You'll need to set POSTGRES_CONNECTION with your database URL

Add these to ~/.config/claude/claude_desktop_config.json?
```

## Resources

**Official MCP Servers**:
- https://github.com/modelcontextprotocol/servers
- Documentation for each server
- Installation instructions

**Claude Desktop Config**:
- Location varies by OS
- Restart required after changes
- JSON format must be valid
