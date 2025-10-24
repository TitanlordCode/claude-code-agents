# Tech-Specific File Template

Use this condensed template when creating tech-specific files:

```markdown
# {Language} + {Framework} {Type} Guidelines
# Auto-generated {date} | Project: {name}

## Context
- **Language**: {lang} {ver}
- **Framework**: {framework} {ver}
- **Testing**: {test-framework}
- **Build**: {build-tool}
- **Linter**: {linter}
- **Formatter**: {formatter}

## Checklist
### Language-Specific
- [ ] {best-practice-1}
- [ ] {best-practice-2}
- [ ] {error-handling}
- [ ] {type-safety}

### Framework-Specific
- [ ] {convention-1}
- [ ] {convention-2}

### Quality
- [ ] Formatter: `{check-cmd}` | Fix: `{fix-cmd}`
- [ ] Linter: `{check-cmd}` | Fix: `{fix-cmd}`
- [ ] Tests: `{test-cmd}`
- [ ] Build: `{build-cmd}`

## Common Patterns
{observed-patterns-brief}

## Commands
```bash
# All checks
{combined-check}

# Auto-fix
{combined-fix}
```

## Notes
- Edit manually to add team conventions
- Commit to `.claude-agents/agents/tech-specific/` to share
```
