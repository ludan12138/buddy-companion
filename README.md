# buddy-companion

A small toy skill for Codex and other code agents that adds a persistent ASCII companion pet to terminal coding sessions.

The companion can hatch, persist across conversations, react to progress, and occasionally speak in-character.

## What's Included

- `SKILL.md`: the skill definition
- `references/sprites.md`: ASCII sprites by species
- `references/personalities.md`: naming and personality guidance

## Commands

- `/buddy`: show the current companion
- `/buddy hatch`: hatch a new companion
- `/buddy mute`: disable quips
- `/buddy unmute`: re-enable quips

## Installation

### Codex

Clone or copy this repository into your skills directory as `buddy-companion`:

```bash
mkdir -p ~/.agents/skills
git clone https://github.com/<your-user>/buddy-companion.git ~/.agents/skills/buddy-companion
```

If your Codex setup uses a different local skills path, copy the folder there instead.

### Claude Code

Copy the repository into:

```bash
~/.claude/skills/buddy-companion
```

## Installation for AI Agents

This repository is designed to be installed as a filesystem-backed skill that an agent can discover and load at runtime.

### Expected Runtime Contract

An agent installing `buddy-companion` should:

1. Place the repository in its local skills directory under the folder name `buddy-companion`
2. Load `SKILL.md` as the entrypoint
3. Resolve `references/sprites.md` and `references/personalities.md` relative to `SKILL.md`
4. Persist companion state to the agent's memory system after hatching or mute-state changes

### Codex Agent Setup

Install to:

```bash
~/.agents/skills/buddy-companion
```

Runtime behavior:

- Read `SKILL.md`
- Read `references/sprites.md` when showing or hatching a companion
- Read `references/personalities.md` when generating the companion profile
- Persist memory to `~/.agents/memory/buddy-companion.md` or an equivalent Codex memory location

### Claude Code Agent Setup

Install to:

```bash
~/.claude/skills/buddy-companion
```

Runtime behavior:

- Load `SKILL.md` from the installed folder
- Resolve reference files from `references/`
- Persist a memory entry named `buddy-companion`

### Generic Agent Setup

For other agent runtimes:

- Keep the repository folder name as `buddy-companion`
- Treat `SKILL.md` as the canonical skill definition
- Preserve the relative `references/` directory layout
- Persist companion state using the fields documented below
- If no native memory system exists, fall back to `~/.buddy/companion.json`

## Persistence

The skill expects the assistant to persist companion state after hatching or mute-state changes.

Typical persistence targets:

- Codex: `~/.agents/memory/buddy-companion.md` or an equivalent memory location
- Claude Code: a memory file named `buddy-companion`
- Fallback environments: `~/.buddy/companion.json`

Persisted fields:

```text
companion: [name]
species: [species]
rarity: [rarity]
personality: "[personality sentence]"
hatchedAt: [YYYY-MM-DD]
muted: [true/false]
```

## Usage Notes

- Quips should stay infrequent and context-aware.
- Companion replies should not be injected into raw command output, diffs, or error logs.
- If the user addresses the companion by name, the assistant can respond in-character.

## Repository Layout

```text
buddy-companion/
├── SKILL.md
├── README.md
├── LICENSE
├── .gitignore
└── references/
    ├── personalities.md
    └── sprites.md
```

## License

MIT. See `LICENSE`.
