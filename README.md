# Dotfiles

Meine persönlichen Konfigurationsdateien für Claude Code und andere Tools.

## Claude Code Commands

Custom Slash-Commands für Claude Code. Nutzung: `/command-name` im CLI.

| Command | Beschreibung |
|---------|--------------|
| `/cos` | Chief of Staff - Morning Briefing, Tasks, Emails (Mobile) |
| `/rename-files` | Dateien nach Namenskonventionen umbenennen und organisieren |

## Setup

### Lokal (Mac)
```bash
# Repo klonen
git clone git@github.com:rknoerk/dotfiles.git ~/dotfiles

# Symlink erstellen
ln -s ~/dotfiles/.claude ~/.claude
```

### GitHub Codespaces

1. GitHub Settings → Codespaces → Dotfiles
2. "Automatically install dotfiles" aktivieren
3. Repository `rknoerk/dotfiles` auswählen

Claude Code installieren:
```bash
npm install -g @anthropic-ai/claude-code
claude
```
