# Buddy Growth Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a lightweight growth system to `buddy-companion` without adding new commands or game-heavy mechanics.

**Architecture:** Keep the implementation documentation-first. Define the growth model in `SKILL.md`, explain it in `README.md`, and protect it with a lightweight repository contract test.

**Tech Stack:** Markdown, POSIX shell, git

---

### Task 1: Add a Failing Contract Test

**Files:**
- Create: `tests/skill-growth-contract.sh`

- [ ] **Step 1: Write the failing contract test**

```sh
#!/bin/sh
set -eu

repo_dir="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
skill_file="$repo_dir/SKILL.md"
readme_file="$repo_dir/README.md"
```

- [ ] **Step 2: Run the contract test to verify red**

Run: `sh tests/skill-growth-contract.sh`  
Expected: FAIL because `SKILL.md` does not yet contain the growth contract.

### Task 2: Document the Growth Contract

**Files:**
- Modify: `SKILL.md`

- [ ] **Step 1: Add a `Growth` section**

Document:

- the four state concepts
- daily/session-driven updates
- visible versus hidden state
- backward compatibility for older memory files

- [ ] **Step 2: Update `/buddy` display behavior**

Document that `/buddy` still shows the sprite block and adds a single-line daily summary beginning with `Today:`.

### Task 3: Update User Documentation

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Describe the lightweight growth system**

Document:

- the growth philosophy
- persisted fields
- compatibility notes
- a sample `/buddy` output summary

### Task 4: Verify Green

**Files:**
- Test: `tests/skill-growth-contract.sh`

- [ ] **Step 1: Run the contract test**

Run: `sh tests/skill-growth-contract.sh`  
Expected: PASS with exit code `0`.

- [ ] **Step 2: Inspect repository changes**

Run: `git status --short`  
Expected: updated docs and test files listed.
