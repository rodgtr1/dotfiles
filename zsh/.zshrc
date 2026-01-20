# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load omarchy-zsh configuration
if [[ -d /usr/share/omarchy-zsh/conf.d ]]; then
  for config in /usr/share/omarchy-zsh/conf.d/*.zsh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

# Load omarchy-zsh functions and aliases
if [[ -d /usr/share/omarchy-zsh/functions ]]; then
  for func in /usr/share/omarchy-zsh/functions/*.zsh; do
    [[ -f "$func" ]] && source "$func"
  done
fi

# Load custom user functions
[[ -f "$HOME/dotfiles/zsh/functions.zsh" ]] && source "$HOME/dotfiles/zsh/functions.zsh"

# ================================================
#                 Oh My ZSH config
# ================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# ================================================
#                 Helpers
# ================================================

# Create Python projects
mkpy() {
  local name="$1"
  [[ -z "$name" ]] && { echo "Usage: mkpy <projectname>"; return 2; }

  # Capture ALL output; only print it if uvmk fails.
  local out
  out="$(uvmk "$name" 2>&1)" || { echo "$out"; return 1; }

  cd "$name" || return $?
  source ".venv/bin/activate" || return $?

  echo "✅ $name activated and ready"
}

# Run Claude prompt in terminal
cpp() {
  claude -p "$*"
}

# ===============================================
#                 Paths
# ===============================================

path=(
  $HOME/.local/bin
  $HOME/.cargo/bin
  $path
)
export PATH

export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt

# ================================================
#                 Aliases
# ================================================

# Get current branch name
alias k='kubectl'

# ================================================
#                 Inits
# ================================================

[[ -r " <(flux completion zsh)" ]] && . <(flux completion zsh)

eval "$(starship init zsh)"
