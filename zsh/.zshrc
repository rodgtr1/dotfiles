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

# ================================================
#                 Inits
# ================================================

eval "$(starship init zsh)"

