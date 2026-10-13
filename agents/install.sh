# agents/install.sh - sourced by installer.sh (bash). Expects utils.zsh helpers.
#
# Shares one AGENTS.md and one skills/ dir between claude, codex and pi.
# Skills are linked one-by-one (not the whole dir) because the tools keep
# their own managed content in their skills dirs (e.g. ~/.claude/skills/synced,
# ~/.codex/skills/.system) and must not write into this repo.

__dotfile_info "Setting up AI agent instructions and skills"

agents_dir="$DOTFILES/agents"

# Symlink $1 (target) at $2 (link). Fails if anything else is already there.
__agents_link() {
    local target=$1 link=$2
    mkdir -p "$(dirname "$link")"
    if [ "$(realpath "$link" 2>/dev/null)" = "$(realpath "$target")" ]; then
        return
    fi
    if [ -e "$link" ] || [ -L "$link" ]; then
        __dotfile_error "$link already exists; move it away and re-run"
        return 1
    fi
    ln -s "$target" "$link"
    __dotfile_success "Linked: $link -> $target"
}

# Global instructions. Claude Code only reads CLAUDE.md.
for link in "$HOME/.claude/CLAUDE.md" "$HOME/.codex/AGENTS.md" "$HOME/.pi/agent/AGENTS.md"; do
    __agents_link "$agents_dir/AGENTS.md" "$link"
done

# Skills. ~/.agents/skills is read by both codex and pi; claude needs its own.
for skills_dir in "$HOME/.claude/skills" "$HOME/.agents/skills"; do
    mkdir -p "$skills_dir"
    for skill in "$agents_dir"/skills/*/; do
        [ -d "$skill" ] || continue
        __agents_link "${skill%/}" "$skills_dir/$(basename "$skill")"
    done
    # Prune links to skills that were removed from the repo.
    for link in "$skills_dir"/*; do
        if [ -L "$link" ] && [ ! -e "$link" ] && [[ $(readlink "$link") == "$agents_dir/skills/"* ]]; then
            rm "$link"
            __dotfile_info "Removed stale skill link: $link"
        fi
    done
done

__dotfile_success "Agent config linked"
