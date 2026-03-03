# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ===============================================
# 1. CORE ZSH CONFIG (Fixes fzf issue)
# ===============================================
# Initialize completion engine BEFORE Omarchy loads
autoload -Uz compinit
compinit

# ===============================================
# 2. LOAD OMARCHY DEFAULTS
# ===============================================
[[ -f /usr/share/omarchy-zsh/shell/zoptions ]] && source /usr/share/omarchy-zsh/shell/zoptions
[[ -f /usr/share/omarchy-zsh/shell/all ]] && source /usr/share/omarchy-zsh/shell/all

# ===============================================
# 3. PLUGINS (Manual Loading)
# ===============================================
# Source autosuggestions from system path (standard Arch location)
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Source syntax highlighting (optional, but highly recommended)
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ===============================================
# 4. USER CUSTOMIZATIONS
# ===============================================
# Load custom user functions
[[ -f "$HOME/dotfiles/zsh/functions.zsh" ]] && source "$HOME/dotfiles/zsh/functions.zsh"

path=(
  $HOME/.local/bin
  $HOME/.cargo/bin
  $path
)
export PATH
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt

# Aliases
alias k='kubectl'

# Helper Functions
mkpy() {
  local name="$1"
  [[ -z "$name" ]] && { echo "Usage: mkpy <projectname>"; return 2; }
  local out
  out="$(uvmk "$name" 2>&1)" || { echo "$out"; return 1; }
  cd "$name" || return $?
  source ".venv/bin/activate" || return $?
  echo "✅ $name activated and ready"
}

cpp() {
  claude -p "$*"
}

# ===============================================
# 5. FINAL INIT
# ===============================================
[[ -r " <(flux completion zsh)" ]] && . <(flux completion zsh)

# FORCE EMACS MODE (disable vi mode permanently in shell)
unsetopt vi
bindkey -e

eval "$(starship init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/travis/.lmstudio/bin"
# End of LM Studio CLI section
