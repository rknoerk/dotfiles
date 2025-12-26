#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d "$DOTFILES_DIR/.claude" ]; then
    ln -sf "$DOTFILES_DIR/.claude" "$HOME/.claude"
    echo "✓ Claude Code commands linked"
fi

echo "Dotfiles installed!"
