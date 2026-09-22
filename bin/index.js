#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const os = require('os');

// --- Couleurs ANSI (Thème Violet KAYIM & TRUIX DEV) ---
const VIOLET_LIGHT = '\x1b[38;5;141m';
const VIOLET_MID   = '\x1b[38;5;135m';
const VIOLET_DEEP  = '\x1b[38;5;129m';
const VIOLET_SOFT  = '\x1b[38;5;147m';
const BOLD_VIOLET  = '\x1b[1;38;5;135m';
const BOLD_WHITE   = '\x1b[1;37m';
const GREEN        = '\x1b[1;32m';
const CYAN         = '\x1b[38;5;117m';
const RESET        = '\x1b[0m';

// Nettoyer l'écran
console.clear();
console.log('');

// --- Banner KAYIM & TRUIX DEV ---
console.log(`${VIOLET_LIGHT}  _  __     _ __     _____ __  __ ${RESET}`);
console.log(`${VIOLET_MID} | |/ /    / \\ \\   / /_ _|  \\/  |${RESET}`);
console.log(`${VIOLET_MID} | ' /    / _ \\ \\ / / | || |\\/| |${RESET}`);
console.log(`${VIOLET_DEEP} | . \\   / ___ \\ Y /  | || |  | |${RESET}`);
console.log(`${VIOLET_DEEP} |_|\\_\\ /_/   \\_\\_/  |___|_|  |_|${RESET}`);
console.log(`${VIOLET_SOFT}  ===========================================${RESET}`);
console.log(`${BOLD_VIOLET}     ⚡ TRUIX DEV — SITE CLONER INSTALLER ⚡${RESET}`);
console.log(`${VIOLET_SOFT}  ===========================================${RESET}`);
console.log('');

// Helper pour attendre (sleep)
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function run() {
  // 1. Spinner animé de détection
  const spinChars = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'];
  const msg1 = "Détection de l'environnement Claude Code...";
  for (let i = 0; i < 12; i++) {
    const c = spinChars[i % spinChars.length];
    process.stdout.write(`\r  ${VIOLET_LIGHT}${c}${RESET} ${msg1}`);
    await sleep(60);
  }
  process.stdout.write(`\r  ${GREEN}✔${RESET} ${msg1}  ${GREEN}[OK]${RESET}\n`);

  // 2. Barre de progression animée
  const msg2 = 'Téléchargement du skill site-cloner';
  const total = 20;
  for (let i = 1; i <= total; i++) {
    await sleep(35);
    const filled = '█'.repeat(i);
    const empty = ' '.repeat(total - i);
    const percent = Math.round((i / total) * 100);
    process.stdout.write(`\r  ${VIOLET_LIGHT}⠙${RESET} ${msg2}... [${VIOLET_MID}${filled}${RESET}${empty}] ${percent}%`);
  }
  process.stdout.write(`\r  ${GREEN}✔${RESET} ${msg2}... [${VIOLET_LIGHT}${'█'.repeat(total)}${RESET}] 100%\n`);

  // 3. Déploiement des fichiers
  const sourceDir = path.resolve(__dirname, '..', 'site-cloner');

  if (!fs.existsSync(sourceDir)) {
    console.error(`\n  ❌ Erreur: Dossier source ${sourceDir} introuvable.`);
    process.exit(1);
  }

  // Cible 1 : Projet courant
  const localTarget = path.resolve(process.cwd(), '.claude', 'skills', 'site-cloner');
  fs.mkdirSync(path.dirname(localTarget), { recursive: true });
  fs.cpSync(sourceDir, localTarget, { recursive: true, force: true });

  // Cible 2 : Global (~/.claude/skills)
  const homeDir = os.homedir();
  const globalTarget = path.resolve(homeDir, '.claude', 'skills', 'site-cloner');
  fs.mkdirSync(path.dirname(globalTarget), { recursive: true });
  fs.cpSync(sourceDir, globalTarget, { recursive: true, force: true });

  console.log(`  ${GREEN}✔${RESET} Installé dans le projet actuel : ${CYAN}./.claude/skills/site-cloner${RESET}`);
  console.log(`  ${GREEN}✔${RESET} Installé au niveau global      : ${CYAN}~/.claude/skills/site-cloner${RESET}`);
  console.log('');

  // 4. Encadré final de succès
  console.log(`${VIOLET_MID}  ┌────────────────────────────────────────────────────────┐${RESET}`);
  console.log(`${VIOLET_MID}  │${RESET}  ${BOLD_WHITE}🎉 Installation réussie avec succès !${RESET}                 ${VIOLET_MID}│${RESET}`);
  console.log(`${VIOLET_MID}  │${RESET}                                                        ${VIOLET_MID}│${RESET}`);
  console.log(`${VIOLET_MID}  │${RESET}  ${BOLD_VIOLET}Auteur  :${RESET} ${BOLD_WHITE}KAYIM (TRUIX DEV)${RESET}                           ${VIOLET_MID}│${RESET}`);
  console.log(`${VIOLET_MID}  │${RESET}  ${BOLD_VIOLET}Skill   :${RESET} site-cloner v1.0.0                          ${VIOLET_MID}│${RESET}`);
  console.log(`${VIOLET_MID}  │${RESET}  ${BOLD_VIOLET}Usage   :${RESET} Tapez ${CYAN}/skills${RESET} dans Claude Code pour tester  ${VIOLET_MID}│${RESET}`);
  console.log(`${VIOLET_MID}  └────────────────────────────────────────────────────────┘${RESET}`);
  console.log('');
}

run().catch((err) => {
  console.error('\n❌ Une erreur est survenue :', err.message);
  process.exit(1);
});
