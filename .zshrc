# ──────────────────────────────────────────────────────────────────────────────
# ZSH plugins
# ──────────────────────────────────────────────────────────────────────────────
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ──────────────────────────────────────────────────────────────────────────────
# Aliases & Completion Behavior
# ──────────────────────────────────────────────────────────────────────────────
if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

autoload -Uz compinit
zmodload -i zsh/complist
compinit -u

zstyle ':completion:::::default' menu yes select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ──────────────────────────────────────────────────────────────────────────────
# History Settings
# ──────────────────────────────────────────────────────────────────────────────
HISTCONTROL=ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

# ──────────────────────────────────────────────────────────────────────────────
# fzf Setup & Configuration
# ──────────────────────────────────────────────────────────────────────────────
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,hl:#bd93f9,fg+:#f8f8f2,bg+:-1,hl+:#bd93f9,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,border:#6272a4 --gutter ' '"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix"
export FZY_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_fzf_compgen_path() { fd --hidden . "$1" }
_fzf_compgen_dir()  { fd --type=d --hidden . "$1" }

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local cmd=$1; shift
  case "$cmd" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ──────────────────────────────────────────────────────────────────────────────
# Prompt
# ──────────────────────────────────────────────────────────────────────────────
eval "$(starship init zsh)"
