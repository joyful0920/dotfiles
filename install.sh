#!/bin/bash
# Symlink Claude Code user-level config into ~/.claude/ — item by item,
# never the whole directory. Existing real files are backed up first.

set -euo pipefail

dir=$(
    cd "$(dirname "${BASH_SOURCE:-$0}")"
    pwd
)

CLAUDE_HOME="${HOME}/.claude"
CLAUDE_SRC="${dir}/claude"
timestamp=$(date +%Y%m%d%H%M%S)

mkdir -p "$CLAUDE_HOME"

link() {
    local src="$1" dst="$2"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv -v "$dst" "${dst}.backup.${timestamp}"
    fi
    ln -snfv "$src" "$dst"
}

link "${CLAUDE_SRC}/CLAUDE.md" "${CLAUDE_HOME}/CLAUDE.md"
link "${CLAUDE_SRC}/settings.json" "${CLAUDE_HOME}/settings.json"
link "${CLAUDE_SRC}/hooks" "${CLAUDE_HOME}/hooks"

chmod +x "${CLAUDE_SRC}/hooks/"*.sh

# Remove broken symlinks in ~/.claude that point into this repo
# (files deleted from the repo leave dangling links behind)
find "$CLAUDE_HOME" -maxdepth 1 -type l ! -exec test -e {} \; -print0 2>/dev/null |
    while IFS= read -r -d '' l; do
        case "$(readlink "$l")" in
            "${dir}"/*) rm -v "$l" ;;
        esac
    done

if [ ! -f "${CLAUDE_HOME}/CLAUDE.private.md" ]; then
    echo ""
    echo "NOTE: ${CLAUDE_HOME}/CLAUDE.private.md not found."
    echo "      claude/CLAUDE.md imports it. Create it manually — it stays outside this repo."
fi

echo "Done."
