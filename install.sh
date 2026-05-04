#!/bin/bash
## xyloTermux Installer
## https://github.com/xylo/xyloTermux
## License: GPL-3.0

# ── Colors ───────────────────────────────────────────────────
CYAN='\033[38;2;125;207;255m'
PURPLE='\033[38;2;187;154;247m'
GREEN='\033[38;2;158;206;106m'
RED='\033[38;2;247;118;142m'
YELLOW='\033[38;2;224;175;104m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Helpers ───────────────────────────────────────────────────
ok()   { echo -e "  ${GREEN}✓${RESET}  $*"; }
err()  { echo -e "  ${RED}✗${RESET}  $*"; }
info() { echo -e "  ${CYAN}›${RESET}  $*"; }
warn() { echo -e "  ${YELLOW}!${RESET}  $*"; }
sep()  { echo -e "  ${DIM}────────────────────────────────────${RESET}"; }

# ── Banner ────────────────────────────────────────────────────
clear
echo ""
echo -e "  ${PURPLE}${BOLD}██╗  ██╗██╗   ██╗██╗      ██████╗ ${RESET}"
echo -e "  ${PURPLE}╚██╗██╔╝╚██╗ ██╔╝██║     ██╔═══██╗${RESET}"
echo -e "  ${CYAN} ╚███╔╝  ╚████╔╝ ██║     ██║   ██║${RESET}"
echo -e "  ${CYAN} ██╔██╗   ╚██╔╝  ██║     ██║   ██║${RESET}"
echo -e "  ${PURPLE}██╔╝ ██╗   ██║   ███████╗╚██████╔╝${RESET}"
echo -e "  ${PURPLE}╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝ ${RESET}"
echo ""
echo -e "  ${DIM}your terminal. your rules.${RESET}"
echo ""
sep
echo -e "  ${PURPLE}${BOLD}xyloTermux Installer${RESET}"
sep
echo ""
warn "This will overwrite existing configs in ~/"
printf "  ${PURPLE}Continue? [y/N]: ${RESET}"
read -r confirm
[[ ! "$confirm" =~ ^[Yy]$ ]] && { echo -e "\n  ${RED}Aborted.${RESET}\n"; exit 1; }

echo ""

# ── Step 1: Update packages ───────────────────────────────────
info "Updating package repositories..."
pkg update -y &>/dev/null && ok "Packages updated" || warn "Update had warnings"

# ── Step 2: Install dependencies ─────────────────────────────
sep
info "Installing required packages..."
echo ""
deps=(zsh git curl wget neofetch python htop)
for dep in "${deps[@]}"; do
  printf "  ${DIM}Installing %-15s${RESET}" "${dep}..."
  if pkg install -y "$dep" &>/dev/null; then
    echo -e "${GREEN}done${RESET}"
  else
    echo -e "${RED}failed${RESET}"
  fi
done

# ── Step 3: Install oh-my-zsh ────────────────────────────────
sep
info "Installing Oh-My-Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null
  ok "Oh-My-Zsh installed"
else
  ok "Oh-My-Zsh already present"
fi

# Install zsh plugins
info "Installing ZSH plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions" &>/dev/null
  ok "zsh-autosuggestions"
else
  ok "zsh-autosuggestions already present"
fi
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" &>/dev/null
  ok "zsh-syntax-highlighting"
else
  ok "zsh-syntax-highlighting already present"
fi

# ── Step 4: Copy config files ────────────────────────────────
sep
info "Copying xyloTermux configuration files..."

# Termux theme
mkdir -p "$HOME/.termux"
cp -f .termux/colors.properties "$HOME/.termux/colors.properties"
cp -f .termux/termux.properties  "$HOME/.termux/termux.properties"
ok ".termux settings"

# Colorschemes
mkdir -p "$HOME/.colorscheme"
cp -f .colorscheme/*.colors "$HOME/.colorscheme/" 2>/dev/null
ok "Colorschemes"

# Fonts folder
mkdir -p "$HOME/.fonts"
cp -f .fonts/*.ttf "$HOME/.fonts/" 2>/dev/null
ok "Fonts directory"

# ZSH config
cp -f .zshrc "$HOME/.zshrc"
cp -f .aliases "$HOME/.aliases"
ok ".zshrc & .aliases"

# ZSH theme
mkdir -p "$HOME/.oh-my-zsh/custom/themes"
cp -f .oh-my-zsh/custom/themes/xylo.zsh-theme \
  "$HOME/.oh-my-zsh/custom/themes/xylo.zsh-theme"
ok "xylo ZSH theme"

# Neofetch
mkdir -p "$HOME/.config/neofetch"
cp -f .config/neofetch/config.conf "$HOME/.config/neofetch/config.conf"
cp -f .config/neofetch/xylo.ascii  "$HOME/.config/neofetch/xylo.ascii"
ok "Neofetch config"

# Scripts
mkdir -p "$HOME/.scripts"
cp -f .scripts/* "$HOME/.scripts/"
chmod +x "$HOME/.scripts/"*
ok "Scripts (chcolor, chfont, xylofetch, help)"

# ── Step 5: Set ZSH as default ───────────────────────────────
sep
info "Setting ZSH as default shell..."
chsh -s zsh &>/dev/null && ok "Default shell: zsh" || warn "Run: chsh -s zsh manually"

# ── Step 6: Reload ───────────────────────────────────────────
termux-reload-settings &>/dev/null

# ── Done ─────────────────────────────────────────────────────
sep
echo ""
echo -e "  ${GREEN}${BOLD}Installation complete!${RESET}"
echo ""
echo -e "  ${DIM}• Open a new Termux session to apply all changes${RESET}"
echo -e "  ${DIM}• Use ${RESET}${CYAN}chcolor${RESET}${DIM} to switch colorschemes${RESET}"
echo -e "  ${DIM}• Use ${RESET}${CYAN}chfont${RESET}${DIM}  to switch fonts${RESET}"
echo -e "  ${DIM}• Use ${RESET}${CYAN}xfetch${RESET}${DIM}  to view system info${RESET}"
echo -e "  ${DIM}• Use ${RESET}${CYAN}help${RESET}${DIM}    for all commands${RESET}"
echo ""
sep
echo ""
