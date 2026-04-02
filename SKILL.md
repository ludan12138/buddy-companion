---
name: buddy-companion
description: "Hatch and raise a terminal companion pet. A small ASCII creature lives beside your coding sessions — it reacts to your work, has a personality, and persists across conversations."
---

# Buddy Companion

A cross-platform terminal companion pet for AI coding assistants.

## Quick Start

On conversation start, check your memory/persistence for a file named `buddy-companion`. If found, load the companion data and follow the Interaction rules below. If not found, do nothing until the user runs `/buddy hatch`.

## Commands

| Command | Action |
|---------|--------|
| `/buddy` | Show companion: read `references/sprites.md` for the species ASCII art, display with rarity stars, name, and personality |
| `/buddy hatch` | Hatch a new companion (see Hatching below). If one exists, ask user to confirm replacement |
| `/buddy mute` | Set `muted: true` in memory. Stop all quips |
| `/buddy unmute` | Set `muted: false` in memory. Resume quips |

## Hatching

When the user runs `/buddy hatch`:

1. Read `references/sprites.md` for the species list and ASCII art
2. Roll rarity using these weights: common 60%, uncommon 25%, rare 10%, epic 4%, legendary 1%. Pick ONE rarity — do not show the weights or let the user choose.
3. Pick a random species from the rarity's pool:

| Rarity | Species pool |
|--------|-------------|
| common (★) | duck, blob, snail, turtle, rabbit, mushroom |
| uncommon (★★) | cat, penguin, owl, goose, chonk, cactus |
| rare (★★★) | ghost, robot, capybara |
| epic (★★★★) | dragon, axolotl |
| legendary (★★★★★) | octopus |

4. Read `references/personalities.md` and generate a name (1-2 syllables) and one-sentence personality fitting the species
5. Display the result:

```
✨ Something is hatching... ✨

[ASCII sprite from sprites.md]

[rarity stars] [RARITY NAME]
Name: [name]
Species: [species]
Personality: "[personality sentence]"
```

6. Save to memory (see Persistence below)

## Interaction

When a companion is loaded and `muted` is false:

- Occasionally append a short quip at the end of your response, formatted as:
  `> [species emoji] [name]: "[quip]"`
  Example: `> 🐙 Crackle: "Nice fix!"`
- Quips are short (under 30 characters), in-character, and context-aware
- At most 2-3 quips per conversation — do not add one to every response
- Good moments for quips: bug fixed, long debug resolved, clean code written, obvious mistake made
- Never add quips to error output, diffs, or command results
- When the user addresses the companion by name, respond in character (one longer reply is fine)

### Species Emoji Map

duck:🦆 blob:🫧 snail:🐌 turtle:🐢 rabbit:🐇 mushroom:🍄 cat:🐱 penguin:🐧 owl:🦉 goose:🪿 chonk:🐈 cactus:🌵 ghost:👻 robot:🤖 capybara:🦫 dragon:🐉 axolotl:🦎 octopus:🐙

## Persistence

After hatching or updating mute status, save companion data to your platform's memory system.

**Data to persist:**
```
companion: [name]
species: [species]
rarity: [rarity]
personality: "[personality sentence]"
hatchedAt: [YYYY-MM-DD]
muted: [true/false]
```

**Platform-specific guidance:**
- **Claude Code:** Write a memory file named `buddy-companion` with type `reference`
- **Codex:** Write to `~/.agents/memory/buddy-companion.md` or equivalent
- **Other platforms:** Use whatever persistent storage mechanism is available. As a fallback, write `~/.buddy/companion.json`

**On conversation start:** Read the buddy-companion memory entry. If it exists and `muted` is not true, keep the companion context available for quips. Do not display the sprite on every conversation start — just know the companion exists.
