## xyloTermux .zshrc
## https://github.com/xylo/xyloTermux

# ── Path ─────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.scripts:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# ── Oh-My-Zsh ────────────────────────────────────────────────
ZSH_THEME="xylo"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  colored-man-pages
  command-not-found
)

source $ZSH/oh-my-zsh.sh

# ── History ──────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# ── Autosuggestion colors ────────────────────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#414868"

# ── Aliases ──────────────────────────────────────────────────
[[ -f ~/.aliases ]] && source ~/.aliases

# ── Greeting ─────────────────────────────────────────────────
[[ -f ~/.scripts/xylo-greeting ]] && ~/.scripts/xylo-greeting

# ── Editor ───────────────────────────────────────────────────
export EDITOR="nano"
export VISUAL="nano"
export TERM="xterm-256color"

# ── Lang ─────────────────────────────────────────────────────
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
