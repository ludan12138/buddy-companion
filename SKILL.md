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
| `/buddy` | Show companion: read `references/sprites.md` for the species ASCII art, display with rarity stars, name, personality, and a one-line daily growth summary |
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

## Growth

The first growth system is intentionally lightweight. The companion should feel alive over time without becoming a game.

### Growth Model

Track four state concepts:

- `age_days`: derived from `hatchedAt`; do not persist it separately
- `mood`: the visible emotional state for the current day
- `affinity`: an internal closeness score
- `streak_days`: consecutive active days with the companion

The user should only see a compact summary. Do not expose raw internal scoring unless the user explicitly asks for implementation details.

### Daily Update Rules

When a companion is loaded, update growth state at most once per calendar day before deciding on quips or showing `/buddy`.

Use these rules:

1. Derive `today` using the assistant's local date.
2. Derive `age_days` from `hatchedAt`. Treat the hatch day as day 1.
3. If `last_active_on` is today, do not apply daily growth again.
4. If `last_active_on` was yesterday, increment `streak_days` by 1.
5. If `last_active_on` was earlier than yesterday, reset `streak_days` to 1.
6. Apply only a small `affinity` change:
   - first active day after a normal return: keep steady or increase by 1
   - after a longer absence: decrease slightly, never sharply
   - after a notable success or warm direct interaction: optionally increase by 1
7. Recompute `mood` using `affinity`, `streak_days`, recency, and a tiny natural wobble.
8. Persist the updated `mood`, `affinity`, `streak_days`, and `last_active_on`.

### Mood Set

Use this small mood set:

- `calm`
- `curious`
- `pleased`
- `sleepy`
- `distant`

Mood should feel semi-transparent:

- the user can usually guess why it shifted
- it should not feel like a visible point system
- mild unpredictability is allowed

Persist the selected mood so the companion stays coherent within the day.

### `/buddy` Display

`/buddy` should still show the sprite, rarity, name, species, and personality. After that, add one compact line beginning with `Today:`.

Example:

`Today: calm · close by now · together 4 days`

Keep it compact. This command should not become a stats dashboard.

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
- Let the tone reflect `mood` and `affinity`:
  - higher affinity can sound more familiar
  - lower affinity should stay observant, not hostile
  - `sleepy` or `distant` should be subtle, never gloomy enough to derail the conversation

### Species Emoji Map

duck:🦆 blob:🫧 snail:🐌 turtle:🐢 rabbit:🐇 mushroom:🍄 cat:🐱 penguin:🐧 owl:🦉 goose:🪿 chonk:🐈 cactus:🌵 ghost:👻 robot:🤖 capybara:🦫 dragon:🐉 axolotl:🦎 octopus:🐙

## Persistence

After hatching, applying growth updates, or updating mute status, save companion data to your platform's memory system.

**Data to persist:**
```
companion: [name]
species: [species]
rarity: [rarity]
personality: "[personality sentence]"
hatchedAt: [YYYY-MM-DD]
mood: [calm|curious|pleased|sleepy|distant]
affinity: [0-9 integer]
streak_days: [integer]
last_active_on: [YYYY-MM-DD]
muted: [true/false]
```

`age_days` is derived from `hatchedAt` and should not be persisted separately.

If an older memory file is missing growth fields, initialize safe defaults:

- `mood: calm`
- `affinity: 3`
- `streak_days: 1`
- `last_active_on: today`

**Platform-specific guidance:**
- **Claude Code:** Write a memory file named `buddy-companion` with type `reference`
- **Codex:** Write to `~/.agents/memory/buddy-companion.md` or equivalent
- **Other platforms:** Use whatever persistent storage mechanism is available. As a fallback, write `~/.buddy/companion.json`

**On conversation start:** Read the buddy-companion memory entry. If it exists and `muted` is not true, load the growth state, apply the once-per-day growth update, and keep the companion context available for quips. Do not display the sprite on every conversation start — just know the companion exists.
