# AIDiff

`aidiff` is a portable Agent Skill for explaining Git changes with side-by-side diff tables and a temporary browser-friendly HTML report outside the repository.

It follows the Agent Skills format and can be used by Codex, Claude Code, and other compatible agents.

## Layout

```text
install.sh
skills/aidiff/SKILL.md
```

## Install

The installer creates user-level discovery links for the skill:

```bash
./install.sh --codex   # Codex
./install.sh --claude  # Claude Code
./install.sh --all     # both
```

The skill source remains in this repository; these commands only create agent-specific discovery links.

You can also create the links manually:

### Codex

```bash
mkdir -p ~/.codex/skills
ln -sfn "$(pwd)/skills/aidiff" ~/.codex/skills/aidiff
```

### Claude Code

```bash
mkdir -p ~/.claude/skills
ln -sfn "$(pwd)/skills/aidiff" ~/.claude/skills/aidiff
```

## Dependencies

Runtime requirements:

- Git, for collecting the selected comparison with read-only commands;
- a compatible agent runtime, such as Codex or Claude Code, to execute the skill;
- standard shell utilities including `mktemp` for the temporary report.

The report has no external web or JavaScript dependencies because its CSS is embedded. The `--open` option additionally requires the host’s standard opener: `xdg-open` on Linux, `open` on macOS, or an equivalent command. The installer requires Bash plus `mkdir`, `dirname`, and `ln`.

Python is only needed for the optional skill-validation command described below.

## Use

Ask the agent to run `aidiff` against the current working tree, a commit, branch, or revision range. Supported inputs include:

- no arguments, `--unstaged`, `--cached`, or `--all` for working-tree changes;
- `HEAD` or a commit SHA for a single commit;
- a branch name, `A..B`, or `A...B` for branch and revision comparisons.
- `--open` to open the generated HTML report in the default browser.

Untracked files are excluded by default. The skill only uses read-only Git commands and never modifies the repository.

The normal terminal output is a concise summary and the generated filename; the exact diff and its explanations are kept in the uniquely named temporary HTML report created with `mktemp` under `/tmp`. The HTML report preserves conventional Git-style colors for additions, deletions, hunk headers, and context lines. The agent prints the generated filename as `HTML report: /tmp/aidiff-XXXXXX.html`. Use `--open` to launch the HTML report automatically. The report is never written into the repository.

## Validate

The skill requires YAML frontmatter with a semver version. Validate it with the Codex skill validator when available:

```bash
python /path/to/skill-creator/scripts/quick_validate.py skills/aidiff
```
