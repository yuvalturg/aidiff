#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
skill_dir="${repo_root}/skills/aidiff"

usage() {
  echo "Usage: $0 [--codex] [--claude] [--all]"
  echo
  echo "Creates user-level discovery links for the aidiff skill."
}

link_skill() {
  local destination="$1"
  mkdir -p "$(dirname "${destination}")"
  if [[ -e "${destination}" && ! -L "${destination}" ]]; then
    echo "ERROR: refusing to replace non-symlink ${destination}" >&2
    exit 1
  fi
  ln -sfn "${skill_dir}" "${destination}"
  echo "Linked ${destination} -> ${skill_dir}"
}

codex=false
claude=false
for arg in "$@"; do
  case "${arg}" in
    --codex) codex=true ;;
    --claude) claude=true ;;
    --all) codex=true; claude=true ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: ${arg}" >&2; usage >&2; exit 2 ;;
  esac
done

if ! ${codex} && ! ${claude}; then
  usage
  exit 2
fi

${codex} && link_skill "${HOME}/.codex/skills/aidiff"
${claude} && link_skill "${HOME}/.claude/skills/aidiff"
