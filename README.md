# site-cloner

Un [Agent Skill](https://agentskills.io) pour Claude et d'autres agents IA codeurs qui clone un site web à partir d'une URL : récupération du HTML, capture visuelle, extraction du design system (couleurs, typographie, breakpoints, spacing), puis reconstruction propre en composants **Next.js / TypeScript / Tailwind** — jamais un copier-coller du code source.

Compatible avec **Claude Code**, **Claude.ai** (skills personnalisés) et tout outil qui suit le standard [Agent Skills](https://agentskills.io).

## Ce que fait ce skill

1. **Fetch** — récupère la structure et le contenu de la page cible
2. **Capture visuelle** — inspecte le rendu réel (desktop + mobile) quand un outil de screenshot est disponible ; sinon demande une capture à l'utilisateur si nécessaire
3. **Extraction du design system** — couleurs, typographie, breakpoints, échelle d'espacement, style des composants (voir [references/design-system-extraction.md](site-cloner/references/design-system-extraction.md) pour la méthodologie complète)
4. **Reconstruction** — génère des composants `.tsx` réutilisables en Tailwind, alignés sur les conventions du projet cible
5. **Passe de cohérence visuelle** — s'appuie sur un skill de design frontend si disponible, pour éviter l'effet "clone mécanique"

Le skill rappelle aussi de vérifier la légitimité du clonage (site concurrent, contenu propriétaire) avant de se lancer, sans bloquer le travail pour un usage légitime (inspiration, prototypage, landing pages génériques).

## Installation

### Claude Code

**Option A — clone direct dans tes skills personnels (disponible dans tous tes projets) :**

```bash
git clone https://github.com/<kouakou-web_ai>/site-cloner.git /tmp/site-cloner
mkdir -p ~/.claude/skills
cp -r /tmp/site-cloner/site-cloner ~/.claude/skills/
rm -rf /tmp/site-cloner
```

**Option B — dans un seul projet (committable avec ton repo, partagé avec ton équipe) :**

```bash
git clone https://github.com/<kouakou-web_ai>/site-cloner.git /tmp/site-cloner
mkdir -p .claude/skills
cp -r /tmp/site-cloner/site-cloner .claude/skills/
rm -rf /tmp/site-cloner
```

**Option C — via [skill-installer](https://pypi.org/project/skill-installer/), si tu l'as :**

```bash
ski https://github.com/<ton-username>/site-cloner/blob/main/site-cloner/SKILL.md
```

Une fois installé, vérifie avec `/skills` dans Claude Code — `site-cloner` doit apparaître dans la liste.

### Claude.ai (skill personnalisé)

Télécharge ce repo en `.zip` (bouton vert **Code → Download ZIP** sur GitHub), ne garde que le dossier `site-cloner/` à l'intérieur, zippe-le seul, puis importe-le dans **Réglages → Capacités → Skills** sur claude.ai.

## Utilisation

Donne simplement une URL à Claude avec une intention de clonage/inspiration :

> Clone ce site pour moi en Next.js/Tailwind : https://exemple.com

> Reconstruis cette landing page en gardant mon design system actuel : https://exemple.com

Le skill se déclenche automatiquement dès qu'une URL est fournie avec ce type d'intention — pas besoin de l'invoquer par nom.

## Structure

```
site-cloner/
├── SKILL.md                                  # Instructions principales (chargées à l'activation)
└── references/
    └── design-system-extraction.md           # Méthodologie détaillée d'extraction (chargée à la demande)
```

## Limites connues

- La capture d'écran automatique dépend des outils disponibles dans l'environnement d'exécution (navigateur headless, MCP de browsing). Sans ça, le skill travaille à partir du HTML/CSS et demande une capture manuelle si une fidélité visuelle précise est nécessaire.
- Le skill ne copie jamais de contenu texte propriétaire verbatim (voir la section légitimité dans `SKILL.md`).

## Licence

MIT — voir [LICENSE](LICENSE). Utilise, modifie et redistribue librement.

## Contribuer

Les PR sont bienvenues — en particulier pour étendre le support à d'autres stacks (Vue, Svelte...) ou affiner la méthodologie d'extraction du design system.
