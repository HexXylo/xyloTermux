## xyloTermux ZSH Theme - "xylo.zsh-theme"
## A custom oh-my-zsh theme with nerd font symbols

# Colors
_XYLO_PRIMARY="%F{#bb9af7}"
_XYLO_ACCENT="%F{#7dcfff}"
_XYLO_GREEN="%F{#9ece6a}"
_XYLO_RED="%F{#f7768e}"
_XYLO_YELLOW="%F{#e0af68}"
_XYLO_RESET="%f"

# Git info
xylo_git_info() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  local dirty=""
  [[ -n $(git status --porcelain 2>/dev/null) ]] && dirty="${_XYLO_RED}✗${_XYLO_RESET}"
  echo " ${_XYLO_ACCENT} ${branch}${dirty}${_XYLO_RESET}"
}

# Battery icon
xylo_battery() {
  local bat
  bat=$(termux-battery-status 2>/dev/null | python3 -c "import sys,json; b=json.load(sys.stdin); print(b['percentage'])" 2>/dev/null) || return
  local icon="󰁹"
  [[ $bat -lt 20 ]] && icon="󰂎"
  [[ $bat -lt 50 ]] && icon="󰁽"
  echo " ${_XYLO_YELLOW}${icon} ${bat}%%${_XYLO_RESET}"
}

# Current time
xylo_time() {
  echo "${_XYLO_PRIMARY}$(date +%H:%M)${_XYLO_RESET}"
}

# Directory shortener
xylo_dir() {
  local dir="${PWD/#$HOME/~}"
  echo "${_XYLO_ACCENT}${dir}${_XYLO_RESET}"
}

# Build prompt
setopt PROMPT_SUBST

PROMPT='
${_XYLO_PRIMARY}╭─${_XYLO_RESET} 󰣇 ${_XYLO_PRIMARY}xylo${_XYLO_RESET} $(xylo_dir)$(xylo_git_info)
${_XYLO_PRIMARY}╰─${_XYLO_RESET}${_XYLO_GREEN} ❯${_XYLO_RESET} '

RPROMPT='$(xylo_battery) $(xylo_time)'
