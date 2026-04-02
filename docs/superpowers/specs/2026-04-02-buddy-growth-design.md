# Buddy Companion Growth Design

## Goal

Add a lightweight growth system to `buddy-companion` so the pet feels alive over time without turning into a game layer.

The first version stays intentionally small:

- No new commands
- No levels or evolution trees
- No visible score panels
- No interaction spam

## Product Shape

The companion keeps four long-lived state concepts:

- `age_days`: derived from `hatchedAt`
- `mood`: visible, lightweight emotional state
- `affinity`: hidden internal closeness score
- `streak_days`: visible summary of consecutive active days

The user should feel:

- the same companion persists across conversations
- the companion's tone changes slowly
- long-term presence matters more than chat volume

## Behavior Model

Growth is session-driven, not message-driven.

State updates happen at a few specific moments:

- first load of the companion on a new calendar day
- major positive progress moments
- occasional direct user interaction with the companion

State changes remain small. The user should not be able to "farm" growth by sending many short messages.

## Visibility Model

`/buddy` remains the main explicit display surface.

It should still show:

- sprite
- rarity
- name
- species
- personality

It should additionally show one lightweight summary line, for example:

`Today: calm · close by now · together 4 days`

Detailed internal scores remain hidden.

## Mood Design

The first mood set is:

- `calm`
- `curious`
- `pleased`
- `sleepy`
- `distant`

Mood is semi-transparent:

- the user can often infer why it changed
- it is not perfectly mechanical
- a small natural wobble is allowed

Mood should be persisted so the companion does not feel random within the same day.

## Persistence Contract

Existing companion files must continue to work.

New persisted fields:

- `mood`
- `affinity`
- `streak_days`
- `last_active_on`

Derived field:

- `age_days`

Backward compatibility rule:

If an older memory file is loaded without growth fields, initialize a safe default growth state and continue.

## Repository Impact

This repository is a skill contract repository, not an application runtime.

The implementation therefore lives in:

- `SKILL.md` behavior contract
- `README.md` user-facing documentation
- lightweight contract tests that validate the repository documents the new growth system

## Verification

The repository should include a small contract test that fails until the growth system is documented, then passes after the changes.
