# Extraction du design system — méthodologie

Guide de référence pour l'étape 3 du workflow `site-cloner`. Consulte ce fichier quand tu as le HTML/CSS et/ou les captures d'écran en main et que tu dois en extraire un design system exploitable.

## Couleurs

Ordre de priorité pour trouver la palette :

1. **Variables CSS** (`:root { --primary: ... }`) si présentes dans le `<style>` ou les fichiers CSS liés — c'est la source la plus fiable.
2. **Classes utilitaires répétées** (ex: classes Tailwind déjà présentes sur le site source, `bg-[#1a2b3c]`) — indiquent directement les valeurs hex.
3. **Inspection visuelle du screenshot** — repère : couleur de fond principale, couleur du texte principal, couleur d'accent (boutons CTA, liens), couleur secondaire (souvent dans les badges/tags), couleurs d'état (succès/erreur si visibles).

Restitue une palette de 5 à 8 couleurs maximum (fond, texte, primaire, secondaire, accent, + variantes clair/foncé si le site a un mode sombre). Ne complique pas avec 20 nuances si le site n'en utilise réellement que 5-6.

## Typographie

- Cherche les imports Google Fonts dans le `<head>` (`<link href="fonts.googleapis.com/...">`) ou les `@import` CSS — c'est la source la plus directe.
- Si aucun import trouvé, identifie la famille par son style visuel dans le screenshot (serif vs sans-serif, géométrique vs humaniste) et propose une police proche disponible sur Google Fonts.
- Relève la hiérarchie : taille du H1, du H2, du corps de texte, et les graisses utilisées (regular/medium/bold). Un site pro utilise rarement plus de 4-5 paliers de taille.
- Note si une police différente est utilisée pour les titres vs le corps de texte (pattern courant : une police display pour les titres, une police neutre pour le corps).

## Breakpoints

- Cherche les `@media` queries dans le CSS pour les valeurs exactes.
- À défaut, déduis du comportement observé : la plupart des sites modernes suivent des paliers standards proches de ceux de Tailwind (640px, 768px, 1024px, 1280px). Sauf signal contraire, aligne-toi sur ces valeurs plutôt que d'inventer des breakpoints personnalisés — ça simplifie l'intégration dans un projet Tailwind existant.

## Spacing scale

- Repère l'unité de base récurrente dans les marges/paddings (souvent 4px ou 8px comme incrément).
- Une échelle cohérente suit généralement une progression régulière (4, 8, 12, 16, 24, 32, 48, 64...). Si les valeurs observées sont irrégulières, c'est probablement dû à l'imprécision de l'extraction plutôt qu'à un vrai choix de design — arrondis à l'échelle standard la plus proche plutôt que de reproduire des valeurs bizarres comme `13px` ou `27px`.

## Style des composants

À noter séparément pour chaque type de composant récurrent (boutons, cards, inputs, nav) :

- **Rayon de bordure** : anguleux (0-2px), légèrement arrondi (4-8px), très arrondi (12px+), ou pill (9999px)
- **Ombres** : absentes, subtiles (élévation légère), marquées (effet "flottant")
- **Transitions/animations visibles** : hover states, transitions de couleur, micro-interactions
- **Bordures** : présence de bordures fines vs séparation uniquement par l'espace/l'ombre

## Présentation du résumé à l'utilisateur

Structure recommandée avant de passer à la reconstruction :

```
Couleurs : fond #FFF, texte #1A1A1A, primaire #2563EB, accent #F59E0B
Typographie : Inter (corps), Poppins (titres) — H1 40px/bold, H2 28px/semibold, body 16px/regular
Breakpoints : standards Tailwind (sm/md/lg/xl)
Spacing : échelle 4px, incréments principaux 8/16/24/32/48
Composants : boutons pill avec ombre légère au hover, cards à coins arrondis 12px sans bordure
```

Ce résumé sert de base de validation avant de générer le code — il coûte peu de temps et évite de reconstruire deux fois si l'utilisateur veut ajuster une couleur ou une police avant que le code ne soit généré.
