# xyloTermux

> **your terminal. your rules.**

A sleek, opinionated Termux configuration with a custom color identity — deep space cyan, electric purple, and warm amber. Inspired by [myTermux](https://github.com/mayTermux/myTermux), rebranded and rebuilt as **xylo**.

---

## 📸 Preview

**XyloDark** (default) — deep navy background, cyan + purple accents  
**XyloCyber** — neon green hacker aesthetic  
**XyloFlame** — warm amber & ember tones  
**XyloNight** — emerald + magenta on pitch black  
**XyloAsh** — muted grey-blue calm

---

## 🚀 Quick Install

> ⚠️ Use **Termux from F-Droid** — the Play Store version is unmaintained.  
> Install [Termux](https://f-droid.org/en/packages/com.termux/) and [Termux:API](https://f-droid.org/en/packages/com.termux.api/) first.

**1. Update and install git**
```bash
pkg update && pkg upgrade
pkg install -y git
```

**2. Clone xyloTermux**
```bash
git clone --depth=1 https://github.com/HexXylo/xyloTermux.git
```

**3. Run the installer**
```bash
cd xyloTermux
export COLUMNS LINES
./install.sh
```

**4. Open a new session** — the xylo greeting will appear!

---

## 🎨 Colorschemes

Switch between 5 built-in colorschemes interactively:

```bash
chcolor
```

| Name | Vibe |
|------|------|
| XyloDark | Deep space — default |
| XyloAsh | Muted grey-blue |
| XyloNight | Emerald & magenta |
| XyloFlame | Warm amber & red |
| XyloCyber | Neon green hacker |

---

## 🔤 Fonts

```bash
chfont
```

Add any Nerd Font `.ttf` to `~/.fonts/` and it will appear in the list.  
Recommended: **JetBrainsMono Nerd Font**, **FiraCode Nerd Font**

---

## 🖥️ Commands

| Command | Description |
|---------|-------------|
| `chcolor` | Switch colorscheme |
| `chfont` | Switch font |
| `xfetch` | xylo system info |
| `fetch` | neofetch |
| `help` | List all xylo commands |
| `update` | pkg update + upgrade |
| `matrix` | cmatrix animation |
| `myip` | Show external IP |

---

## 🗂️ Structure

```
xyloTermux/
├── install.sh               ← run this
├── .termux/
│   ├── colors.properties    ← XyloDark default theme
│   └── termux.properties    ← extra keys, keybindings
├── .colorscheme/
│   ├── XyloDark.colors
│   ├── XyloAsh.colors
│   ├── XyloNight.colors
│   ├── XyloFlame.colors
│   └── XyloCyber.colors
├── .oh-my-zsh/custom/themes/
│   └── xylo.zsh-theme       ← custom prompt
├── .config/neofetch/
│   ├── config.conf
│   └── xylo.ascii
├── .scripts/
│   ├── xylo-greeting        ← startup banner
│   ├── xylofetch            ← system fetch
│   ├── chcolor              ← colorscheme switcher
│   ├── chfont               ← font switcher
│   └── help                 ← command reference
├── .zshrc
└── .aliases
```

---

## 📦 Packages Installed

- `zsh` + oh-my-zsh
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `git`, `curl`, `wget`
- `neofetch`
- `python`
- `htop`

---

## License

GPL-3.0 — fork it, remix it, make it yours.
