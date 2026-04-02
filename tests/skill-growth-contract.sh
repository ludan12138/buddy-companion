#!/bin/sh
set -eu

repo_dir="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
skill_file="$repo_dir/SKILL.md"
readme_file="$repo_dir/README.md"

assert_contains() {
  file="$1"
  pattern="$2"

  if ! grep -Fq "$pattern" "$file"; then
    echo "missing pattern in $file: $pattern" >&2
    exit 1
  fi
}

assert_contains "$skill_file" "## Growth"
assert_contains "$skill_file" "age_days"
assert_contains "$skill_file" "mood"
assert_contains "$skill_file" "affinity"
assert_contains "$skill_file" "streak_days"
assert_contains "$skill_file" "Today:"
assert_contains "$readme_file" "Lightweight growth system"
assert_contains "$readme_file" "streak_days"
