# buddy-companion

[中文说明](./README.zh.md)

An ASCII terminal companion that remembers you.

`buddy-companion` is a small skill for Codex and other code agents that adds a persistent pet to terminal coding sessions. It can hatch, persist across conversations, react to progress, occasionally speak in-character, and now grow in a lightweight way over time.

## Why People Try It

- Persistent companion: your buddy survives across conversations.
- Low-noise presence: it reacts occasionally instead of interrupting every turn.
- Lightweight growth system: it now tracks mood, affinity, and streak without becoming a game.
- Open-skill friendly: the repository is small, understandable, and easy to install.

## Terminal Preview

Hatching a companion:

```text
✨ Something is hatching... ✨

    __
  <(· )___
   (  ._>
    `--´

★ COMMON
Name: Pip
Species: duck
Personality: "Pip watches the chaos like a pond philosopher and never hurries a fix."
```

Checking on your buddy later:

```text
    __
  <(· )___
   (  ._>
    `--´

★ COMMON
Name: Pip
Species: duck
Personality: "Pip watches the chaos like a pond philosopher and never hurries a fix."
Today: calm · close by now · together 4 days
```

An occasional in-character quip:

```text
> 🦆 Pip: "Nice steady fix."
```

## Why It Feels Different

Most terminal mascots are static jokes. `buddy-companion` works better as a tiny long-lived presence:

- it remembers who it is
- it remembers whether you have been around lately
- it stays out of the way until the moment feels right

The goal is not to build a pet game. The goal is to make terminal work feel a little warmer.

## Quick Start

### Codex

```bash
mkdir -p ~/.agents/skills
git clone https://github.com/<your-user>/buddy-companion.git ~/.agents/skills/buddy-companion
```

### Claude Code

```bash
cp -R buddy-companion ~/.claude/skills/buddy-companion
```

If your runtime uses a different local skills path, copy the folder there instead.

## Core Commands

- `/buddy`: show the current companion
- `/buddy hatch`: hatch a new companion
- `/buddy mute`: disable quips
- `/buddy unmute`: re-enable quips

## Lightweight Growth System

The repository now documents a deliberately small growth model. This lightweight growth system is meant to make the companion feel alive without turning it into a game UI.

Growth concepts:

- `age_days`: derived from the hatch date
- `mood`: the visible emotional state for the current day
- `affinity`: a hidden closeness score
- `streak_days`: consecutive active days together

The installed skill is expected to apply growth updates once per day, persist the result, and keep `/buddy` compact instead of turning it into a stats panel.

## Installation for AI Agents

This repository is designed to be installed as a filesystem-backed skill that an agent can discover and load at runtime.

Expected runtime contract:

1. Place the repository in the local skills directory under the folder name `buddy-companion`
2. Load `SKILL.md` as the entrypoint
3. Resolve `references/sprites.md` and `references/personalities.md` relative to `SKILL.md`
4. Persist companion state after hatching, growth updates, or mute-state changes

## Persistence

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
mood: [calm|curious|pleased|sleepy|distant]
affinity: [0-9 integer]
streak_days: [integer]
last_active_on: [YYYY-MM-DD]
muted: [true|false]
```

Compatibility notes:

- older memory files without growth fields should still load
- missing growth fields should be initialized with safe defaults
- `age_days` is derived from `hatchedAt` rather than stored directly

## Repository Layout

```text
buddy-companion/
├── SKILL.md
├── README.md
├── README.zh.md
├── LICENSE
├── .gitignore
├── references/
│   ├── personalities.md
│   └── sprites.md
├── docs/
│   └── superpowers/
│       ├── plans/
│       └── specs/
└── tests/
    └── skill-growth-contract.sh
```

## Usage Notes

- Quips should stay infrequent and context-aware.
- Mood should shape the tone of quips, but the companion should never become disruptive.
- Companion replies should not be injected into raw command output, diffs, or error logs.
- If the user addresses the companion by name, the assistant can respond in-character.

## License

MIT. See `LICENSE`.
