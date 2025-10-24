# Conversation Context Manager

This module manages conversation context persistence across agent runs.

## Context Storage

**Location**: `.claude-agents/.cache/context/{agent-type}-last.json`

**Files**:
- `review-last.json` - Last review conversation
- `test-last.json` - Last test conversation
- `precommit-last.json` - Last pre-commit conversation

## Context Structure

```json
{
  "timestamp": "2025-10-24T17:30:00Z",
  "agent": "review|test|precommit",
  "project": {
    "language": "javascript",
    "framework": "vue",
    "testFramework": "vitest"
  },
  "session": {
    "filesReviewed": ["src/App.vue", "src/components/Button.vue"],
    "issuesFound": 3,
    "issuesFixed": 2,
    "status": "completed|in-progress|blocked"
  },
  "insights": [
    "User prefers Composition API over Options API",
    "Team uses TypeScript strict mode",
    "All components require test coverage"
  ],
  "pendingItems": [
    "Fix type error in Button.vue:45",
    "Add tests for UserCard component"
  ],
  "userPreferences": {
    "autoFixFormatting": true,
    "runTestsOnReview": true,
    "verbosity": "concise"
  }
}
```

## Usage in Agents

### On Agent Start

1. **Check for existing context**:
   ```
   Read: .claude-agents/.cache/context/{agent-type}-last.json
   ```

2. **If context exists and recent** (< 24 hours):
   - Load context
   - Summarize previous session
   - Reference pending items
   - Apply user preferences

3. **If context missing or old**:
   - Start fresh
   - Create new context

### During Agent Execution

**Track**:
- Files analyzed/modified
- Issues found/fixed
- User preferences expressed
- Important insights learned
- Pending tasks

### On Agent Completion

1. **Update context**:
   - Timestamp
   - Session summary
   - New insights
   - Pending items
   - Status

2. **Write context file**:
   ```
   Write: .claude-agents/.cache/context/{agent-type}-last.json
   ```

## Context Loading Example

**At agent start**:
```
📋 Previous session (2 hours ago):
- Reviewed 3 files in src/components/
- Fixed 2/3 issues (1 pending)
- Pending: Fix type error in Button.vue:45

Continuing from where we left off...
```

## Context Benefits

1. **Continuity**: Remember previous conversations
2. **Efficiency**: Don't repeat same analysis
3. **Learning**: Accumulate project insights
4. **Preferences**: Remember user choices
5. **Tracking**: Follow up on pending items

## Context Expiry

- **Fresh**: < 1 hour - Full context loaded
- **Recent**: 1-24 hours - Summary only
- **Stale**: > 24 hours - Start fresh (optional load)
- **Very old**: > 7 days - Ignored

## Privacy

- Context stored locally only
- Not committed to git (in .cache/)
- Can be cleared: `rm -rf .claude-agents/.cache/context/`
- No sensitive data stored (only file paths, issue descriptions)

## Context Size Management

- Maximum 50 insights (FIFO)
- Maximum 20 pending items (FIFO)
- Automatic pruning of old data
- Keep file size < 10KB
