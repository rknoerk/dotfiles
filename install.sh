#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d "$DOTFILES_DIR/.claude" ]; then
    ln -sf "$DOTFILES_DIR/.claude" "$HOME/.claude"
    echo "✓ Claude Code commands linked"
fi

# Install Claude Code CLI
if command -v npm &> /dev/null; then
    echo "Installing Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code
    echo "✓ Claude Code CLI installed"
else
    echo "⚠ npm not found, skipping Claude Code CLI installation"
fi

echo "Dotfiles installed!"
