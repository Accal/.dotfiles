# Shared AI assets (`~/.ai`)

This directory is the canonical source for cross-agent assets that should stay aligned across Claude Code and Codex.

## Layout

- `skills/` - First-party shared skills, synchronized into each agent.
- `prompts/` - Reusable prompt templates/snippets.
- `mcp/` - Non-secret MCP server templates and examples.
- `agents/` - Agent-specific overlay files applied after shared sync.
- `external-skills.json` - Declarative manifest for third-party skill installs.

## External skills

`run_onchange_after_35-install-agent-skills.sh.tmpl` reads `external-skills.json` and installs enabled entries with:

```sh
npx skills add <source> -g --copy -y -a claude-code -a codex
```

Set `enabled` to `true` for entries you want installed automatically.
