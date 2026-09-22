---
name: site-cloner
description: Clone un site web à partir d'un lien fourni par l'utilisateur — récupère le HTML/CSS, tente une capture visuelle, extrait le design system (couleurs, typographie, breakpoints, espacements), puis reconstruit le résultat en composants Next.js/TypeScript/Tailwind propres et cohérents (jamais un copier-coller du code source). Utilise systématiquement ce skill dès que l'utilisateur donne une URL et demande de "cloner", "reproduire", "s'inspirer de", "recréer le design de", "reconstruire" ou "faire un site/une page qui ressemble à" un site existant — même si le mot "cloner" n'est pas utilisé explicitement.
license: MIT
---

# Site Cloner

Reconstruit un site web existant (à partir d'une URL) sous forme de composants Next.js/TypeScript/Tailwind propres, fidèles visuellement mais jamais copiés bruts. Le but n'est pas de dupliquer le code source (souvent minifié, illisible, non conventionnel) mais de comprendre le design et de le reconstruire proprement.

## Avant de commencer : vérifier la légitimité

Si l'URL correspond à un concurrent direct de l'utilisateur, à un site avec une identité de marque forte (logo, charte, contenu propriétaire), ou si l'utilisateur veut une reproduction pixel-perfect destinée à la mise en prod publique, fais une remarque brève (une phrase) avant de continuer — pas besoin de bloquer, juste s'assurer que c'est bien de l'inspiration/prototypage et pas une duplication problématique. Pour un site de référence générique (landing page, portfolio, SaaS non concurrent), continue directement sans poser de question.

Ne copie jamais de contenu texte propriétaire (textes marketing, témoignages clients, articles) verbatim — reformule ou utilise un contenu placeholder, sauf si l'utilisateur possède le site ou a explicitement les droits dessus.

## Workflow

### Étape 1 — Fetch de la page

Récupère le contenu rendu de l'URL fournie (structure, texte, liens, images référencées) avec l'outil de fetch web disponible dans l'environnement.

Si tu as besoin du HTML/CSS brut (classes, structure DOM exacte, variables CSS) plutôt que du texte extrait, et que l'environnement le permet, complète avec une requête brute (ex: `curl`) sur le domaine cible. Dans la plupart des cas, un fetch avec extraction texte/markdown suffit pour comprendre la structure ; pour les détails fins de CSS (couleurs exactes, media queries), privilégie l'inspection visuelle (étape 2) plutôt que de parser du CSS minifié.

Note ce que tu identifies :
- Structure de la page (header, hero, sections, footer, nav)
- Composants récurrents (cards, boutons, formulaires)
- Contenu texte (à reformuler, voir section précédente)

### Étape 2 — Capture visuelle

Le rendu réel (mise en page, espacements, responsive) est ce qui compte le plus pour un clonage fidèle — le HTML seul ne suffit pas à percevoir l'agencement visuel.

- Si un outil de capture d'écran / navigateur headless est disponible (MCP de browsing, Chrome, Playwright avec accès réseau au domaine), utilise-le pour obtenir un screenshot desktop et un screenshot mobile.
- **Si aucun outil de ce type n'est disponible** : base-toi sur le HTML/texte extrait à l'étape 1 pour déduire la structure, et **demande à l'utilisateur une capture d'écran** (desktop + mobile si pertinent) s'il a besoin d'une fidélité visuelle précise — notamment pour les espacements, les proportions, ou un design complexe. Ne bloque pas le travail en attendant : propose une première reconstruction basée sur le HTML, et affine si l'utilisateur fournit des captures.

### Étape 3 — Extraction du design system

À partir du HTML/CSS récupéré et/ou des captures d'écran, identifie couleurs, typographie, breakpoints, spacing scale et style des composants.

Pour la méthodologie détaillée d'extraction (où chercher chaque token, comment déduire une palette à partir d'un screenshot, comment identifier une échelle d'espacement cohérente), consulte [references/design-system-extraction.md](references/design-system-extraction.md).

Présente le design system extrait sous forme de résumé structuré (pas juste dans le code) avant de passer à la reconstruction, pour que l'utilisateur puisse valider ou ajuster.

### Étape 4 — Reconstruction en Next.js/TypeScript/Tailwind

Ne copie jamais le code source brut. Reconstruis :

- **Composants réutilisables** (`.tsx`), typés, découpés logiquement (ex: `Hero.tsx`, `PricingCard.tsx`, `Navbar.tsx`) — livrés comme fichiers prêts à être intégrés dans un projet existant, pas comme un projet Next.js complet avec sa propre structure de dossiers, sauf si l'utilisateur demande explicitement un projet autonome.
- **Tailwind** : traduis le design system extrait en classes Tailwind ; si des couleurs/tailles reviennent souvent, propose les entrées correspondantes pour `tailwind.config` plutôt que des valeurs arbitraires répétées partout.
- **Conventions du projet cible** : si l'utilisateur a un projet ouvert avec ses propres conventions (gestion d'état, structure de dossiers `app/`, etc.), aligne-toi dessus plutôt que d'imposer une structure générique.
- **Responsive** : reproduis le comportement observé aux breakpoints identifiés, pas juste le rendu desktop.

### Étape 5 — Passage par un skill de design (si disponible)

Avant de livrer le résultat final, si un skill de design frontend (ex: `frontend-design`) est disponible dans l'environnement, consulte-le et applique ses principes pour :

- Vérifier que la hiérarchie typographique est intentionnelle et pas juste calquée mécaniquement
- Éviter les défauts génériques si le site source lui-même avait des tics de template
- S'assurer que l'ensemble a une cohérence visuelle réelle, pas un assemblage de composants clonés indépendamment

C'est cette étape qui évite l'effet "clone mécanique moche" : le but final est un résultat qui a l'air pensé, pas recopié.

## Livraison

- Résume en quelques lignes ce qui a été extrait (design system) et ce qui a été reconstruit.
- Si le résultat dépasse ~20 lignes de code ou plusieurs composants, livre-le comme fichier(s) plutôt qu'inline dans la conversation.
- Signale explicitement tout ce que tu n'as pas pu vérifier faute de capture d'écran (ex: "espacements approximatifs, à ajuster avec un visuel").
