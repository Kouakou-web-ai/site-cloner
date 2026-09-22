#!/usr/bin/env bash
# ==============================================================================
#  ⚡ SITE-CLONER INSTALLER
#  Crafted with care by KAYIM — TRUIX DEV
#  Repository: https://github.com/Kouakou-web-ai/site-cloner
# ==============================================================================

set -e

# --- Définition des couleurs ANSI (Thème Violet) ---
VIOLET_DEEP="\033[38;5;129m"
VIOLET_MID="\033[38;5;135m"
VIOLET_LIGHT="\033[38;5;141m"
VIOLET_SOFT="\033[38;5;147m"
VIOLET_PALE="\033[38;5;183m"
BOLD_VIOLET="\033[1;38;5;135m"
BOLD_WHITE="\033[1;37m"
GREEN="\033[1;32m"
CYAN="\033[38;5;117m"
RESET="\033[0m"

# Configuration UTF-8 si disponible
export LC_ALL=en_US.UTF-8 2>/dev/null || export LC_ALL=C.UTF-8 2>/dev/null || true

# --- Affichage du Banner KAYIM & TRUIX DEV ---
clear 2>/dev/null || true
echo ""

printf "${VIOLET_LIGHT}%s${RESET}\n" "  _  __     _ __     _____ __  __ "
printf "${VIOLET_MID}%s${RESET}\n"   " | |/ /    / \\ \\   / /_ _|  \\/  |"
printf "${VIOLET_MID}%s${RESET}\n"   " | ' /    / _ \\ \\ / / | || |\\/| |"
printf "${VIOLET_DEEP}%s${RESET}\n"  " | . \\   / ___ \\ Y /  | || |  | |"
printf "${VIOLET_DEEP}%s${RESET}\n"  " |_|\\_\\ /_/   \\_\\_/  |___|_|  |_|"

echo -e "${VIOLET_SOFT}  ===========================================${RESET}"
echo -e "${BOLD_VIOLET}     ⚡ TRUIX DEV — SITE CLONER INSTALLER ⚡${RESET}"
echo -e "${VIOLET_SOFT}  ===========================================${RESET}"
echo ""

# --- Fonction spinner d'attente animée ---
spinner() {
  local msg="$1"
  local delay=0.07
  local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local count=12
  while [ $count -gt 0 ]; do
    local temp=${spinstr#?}
    printf "\r  ${VIOLET_LIGHT}%c${RESET} %s" "$spinstr" "$msg"
    spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    count=$((count - 1))
  done
  printf "\r  ${GREEN}✔${RESET} %s  ${GREEN}[OK]${RESET}\n" "$msg"
}

# --- Fonction barre de progression animée ---
progress_bar() {
  local msg="$1"
  local total=20
  for i in $(seq 1 $total); do
    sleep 0.03
    local filled=""
    for j in $(seq 1 $i); do filled="${filled}█"; done
    local empty=""
    local remain=$((total - i))
    if [ $remain -gt 0 ]; then
      for j in $(seq 1 $remain); do empty="${empty} "; done
    fi
    local percent=$((i * 100 / total))
    printf "\r  ${VIOLET_LIGHT}⠙${RESET} %s... [${VIOLET_MID}%s${RESET}%s] %d%%" "$msg" "$filled" "$empty" "$percent"
  done
  printf "\r  ${GREEN}✔${RESET} %s... [${VIOLET_LIGHT}%s${RESET}] 100%%\n" "$msg" "$filled"
}

# --- Cible d'installation ---
IS_LOCAL=false
for arg in "$@"; do
  if [ "$arg" == "--local" ] || [ "$arg" == "-l" ]; then
    IS_LOCAL=true
  fi
done

if [ "$IS_LOCAL" = true ]; then
  TARGET_DIR="./.claude/skills/site-cloner"
  TARGET_DISPLAY="./.claude/skills/site-cloner (projet local)"
else
  TARGET_DIR="$HOME/.claude/skills/site-cloner"
  TARGET_DISPLAY="~/.claude/skills/site-cloner (global)"
fi

# --- Étape 1 : Détection environnement ---
spinner "Détection de l'environnement Claude Code..."

# --- Étape 2 : Téléchargement du skill ---
progress_bar "Téléchargement du skill site-cloner"

TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'site-cloner')

# Nettoyage automatique en sortie
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# Récupération des fichiers du skill
if [ -d "./site-cloner" ] && [ -f "./site-cloner/SKILL.md" ]; then
  # Installation locale depuis le repo déjà cloné
  cp -r "./site-cloner" "$TMP_DIR/"
else
  # Téléchargement via git ou curl
  if command -v git >/dev/null 2>&1; then
    git clone --depth 1 -q https://github.com/Kouakou-web-ai/site-cloner.git "$TMP_DIR/repo" 2>/dev/null
    cp -r "$TMP_DIR/repo/site-cloner" "$TMP_DIR/site-cloner"
  else
    curl -fsSL https://github.com/Kouakou-web-ai/site-cloner/archive/refs/heads/main.tar.gz | tar -xz -C "$TMP_DIR"
    cp -r "$TMP_DIR/site-cloner-main/site-cloner" "$TMP_DIR/site-cloner"
  fi
fi

# --- Étape 3 : Déploiement dans le répertoire cible ---
mkdir -p "$(dirname "$TARGET_DIR")"
rm -rf "$TARGET_DIR"
cp -r "$TMP_DIR/site-cloner" "$TARGET_DIR"

echo -e "  ${GREEN}✔${RESET} Installation dans ${CYAN}${TARGET_DISPLAY}${RESET}"
echo ""

# --- Encadré final de succès ---
echo -e "${VIOLET_MID}  ┌────────────────────────────────────────────────────────┐${RESET}"
echo -e "${VIOLET_MID}  │${RESET}  ${BOLD_WHITE}🎉 Installation réussie avec succès !${RESET}                 ${VIOLET_MID}│${RESET}"
echo -e "${VIOLET_MID}  │${RESET}                                                        ${VIOLET_MID}│${RESET}"
echo -e "${VIOLET_MID}  │${RESET}  ${BOLD_VIOLET}Auteur  :${RESET} ${BOLD_WHITE}KAYIM (TRUIX DEV)${RESET}                           ${VIOLET_MID}│${RESET}"
echo -e "${VIOLET_MID}  │${RESET}  ${BOLD_VIOLET}Skill   :${RESET} site-cloner v1.0.0                          ${VIOLET_MID}│${RESET}"
echo -e "${VIOLET_MID}  │${RESET}  ${BOLD_VIOLET}Usage   :${RESET} Tapez ${CYAN}/skills${RESET} dans Claude Code pour tester  ${VIOLET_MID}│${RESET}"
echo -e "${VIOLET_MID}  └────────────────────────────────────────────────────────┘${RESET}"
echo ""
