# AIDiff

`aidiff` is a portable Agent Skill for explaining Git changes with a browser-based, side-by-side diff report.

It follows the Agent Skills format and can be used by Codex, Claude Code, and other compatible agents.

## Layout

```text
skills/aidiff/SKILL.md
```

## Install for Codex

```bash
mkdir -p ~/.codex/skills
ln -sfn "$(pwd)/skills/aidiff" ~/.codex/skills/aidiff
```

## Install for Claude Code

```bash
mkdir -p ~/.claude/skills
ln -sfn "$(pwd)/skills/aidiff" ~/.claude/skills/aidiff
```

The skill source remains in this repository; the commands above only create agent-specific discovery links.

## Use

Ask the agent to run `aidiff` against the current working tree, a commit, branch, or revision range.

## Validate

The skill requires YAML frontmatter with a semver version. Validate it with the Codex skill validator when available:

```bash
python /path/to/skill-creator/scripts/quick_validate.py skills/aidiff
```
