# ──────────────────────────────────────────────────────────────────────────────
# Homebrew & Path Configuration
# ──────────────────────────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/Scripts:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="/Users/jbedm/.local/bin:$PATH"
source "$(brew --prefix)/etc/profile.d/z.sh"

# VimTeX (TeX Live)
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
export PATH="$/usr/local/texlive/2024/bin/universal-darwin:$PATH"

# Unison
export UNISONLOCALHOSTNAME=FixedHostname

# ──────────────────────────────────────────────────────────────────────────────
# Oh My Zsh Core & Plugins
# ──────────────────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# auto‐update OMZ every 7 days
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# ──────────────────────────────────────────────────────────────────────────────
# Aliases & Completion Behavior
# ──────────────────────────────────────────────────────────────────────────────
# source custom aliases if present
if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

# enable menu selection for default completions
zstyle ':completion:::::default' menu yes select

# ──────────────────────────────────────────────────────────────────────────────
# History Settings
# ──────────────────────────────────────────────────────────────────────────────
# no commands starting with space in history
HISTCONTROL=ignorespace
# history sizes
HISTSIZE=1000
HISTFILESIZE=2000

# ──────────────────────────────────────────────────────────────────────────────
# Editor Preference
# ──────────────────────────────────────────────────────────────────────────────
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ──────────────────────────────────────────────────────────────────────────────
# fzf Setup & Configuration
# ──────────────────────────────────────────────────────────────────────────────
# load fzf keybindings & completions
eval "$(fzf --zsh)"

# use fd instead of find for fzf sources
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix"
export FZY_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"  # legacy fzy var

# allow fzf to use fd for zsh completions
_fzf_compgen_path() { fd --hidden . "$1" }
_fzf_compgen_dir()  { fd --type=d --hidden . "$1" }

# preview panes
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# advanced fzf argument‐completion previews
_fzf_comprun() {
  local cmd=$1; shift
  case "$cmd" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Bat (cat replacement) theme
export BAT_THEME=Dracula

# ──────────────────────────────────────────────────────────────────────────────
# Prompt
# ──────────────────────────────────────────────────────────────────────────────
eval "$(starship init zsh)"
