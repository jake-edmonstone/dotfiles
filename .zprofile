# ──────────────────────────────────────────────────────────────────────────────
# Homebrew & Path Configuration
# ──────────────────────────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.dotfiles/Scripts:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="/Users/jbedm/.local/bin:$PATH"
source "$(brew --prefix)/etc/profile.d/z.sh"

# VimTeX (TeX Live)
# export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
# export PATH="/usr/local/texlive/2024/bin/universal-darwin:$PATH"

# Typst Root
export TYPST_ROOT=/Users/jbedm/typst/

# Unison
export UNISONLOCALHOSTNAME=FixedHostname

# Haskell
#[ -f "/Users/jbedm/.ghcup/env" ] && . "/Users/jbedm/.ghcup/env" # ghcup-env

# ──────────────────────────────────────────────────────────────────────────────
# Editor Preference
# ──────────────────────────────────────────────────────────────────────────────
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Bat (cat replacement) theme
export BAT_THEME=Dracula
