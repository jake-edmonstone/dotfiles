#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${HOME}/.dotfiles"
BREWFILE="${DOTFILES}/Brewfile"

#----------------------------
# Helpers
#----------------------------
msg() { printf "\033[1;32m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33mWARNING:\033[0m %s\n" "$*"; }
is_arm64() { [[ "$(uname -m)" == "arm64" ]]; }

#----------------------------
# Xcode CLT + Rosetta
#----------------------------
if ! xcode-select -p >/dev/null 2>&1; then
  msg "Installing Xcode Command Line Tools"
  xcode-select --install || true
  warn "If a popup appeared, finish CLT install, then re-run this script."
fi

if is_arm64; then
  if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
    msg "Installing Rosetta"
    softwareupdate --install-rosetta --agree-to-license || true
  fi
fi

#----------------------------
# Homebrew
#----------------------------
if ! command -v brew >/dev/null 2>&1; then
  msg "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ensure brew in PATH now
if is_arm64; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

msg "Updating Homebrew"
brew update

#----------------------------
# Brew Bundle from dotfiles
#----------------------------
if [[ -f "$BREWFILE" ]]; then
  msg "Running brew bundle from ${BREWFILE}"
  brew bundle --file="$BREWFILE"
else
  warn "No Brewfile at ${BREWFILE}; skipping bundle."
fi

# fzf keybindings/completion (safe to re-run)
if brew list fzf >/dev/null 2>&1; then
  "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish || true
fi

#----------------------------
# Oh My Zsh
#----------------------------
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  msg "Installing Oh My Zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# set default shell to zsh
if [[ "$SHELL" != *"zsh" ]]; then
  msg "Setting default shell to zsh"
  chsh -s /bin/zsh || warn "Could not change default shell; do it manually."
fi

#----------------------------
# Starship (assumes Brewfile installs it)
#----------------------------
if ! command -v starship >/dev/null 2>&1; then
  warn "starship not found. Ensure it’s in your Brewfile or install via 'brew install starship'."
fi

#----------------------------
# Ghostty (assumes Brewfile installs it)
#----------------------------
if ! brew list --cask ghostty >/dev/null 2>&1; then
  warn "Ghostty not installed. Ensure it’s in your Brewfile's casks."
fi

#----------------------------
# Symlink dotfiles
#   Symlink every top-level entry from ~/.dotfiles into $HOME
#   Skips .git and obvious junk. Uses ln -snf for idempotence.
#----------------------------
msg "Symlinking dotfiles into \$HOME"
shopt -s dotglob nullglob
for src in "${DOTFILES}"/* "${DOTFILES}"/.*; do
  name="$(basename "$src")"
  # skip special entries and repo internals
  case "$name" in
  . | .. | .git | .gitignore | .gitattributes | .github | .DS_Store) continue ;;
  esac
  dst="${HOME}/${name}"
  # make sure parent exists
  mkdir -p "$(dirname "$dst")"
  ln -snf "$src" "$dst"
done
shopt -u dotglob nullglob

#----------------------------
# tmux + TPM + plugin install
#----------------------------
if ! command -v tmux >/dev/null 2>&1; then
  warn "tmux not found. Ensure it’s in your Brewfile."
else
  if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
    msg "Installing tmux plugin manager (TPM)"
    git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
  fi
  # non-interactive plugin install
  if [[ -x "${HOME}/.tmux/plugins/tpm/bin/install_plugins" ]]; then
    msg "Installing tmux plugins via TPM"
    tmux start-server
    "${HOME}/.tmux/plugins/tpm/bin/install_plugins" || true
    tmux kill-server || true
  fi
fi

msg "Done. Open a new terminal session for zsh and starship."
