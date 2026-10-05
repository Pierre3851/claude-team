---
name: documentation
description: "Charte de rédaction de la documentation d'un projet (site de documentation, guide utilisateur, documentation d'onboarding) : structure imposée, diagrammes Mermaid, aucun code source, écriture « façon Material for MkDocs » et vérifications. À appliquer dès qu'il faut créer, compléter ou restructurer la documentation d'un projet."
---

# Charte de documentation

Cette charte s'applique **entière** dès qu'une documentation de projet est demandée. Le niveau de
qualité du projet décide **si** une documentation complète est due ; il ne réduit pas cette charte
quand elle l'est.

## 1. Le lecteur et le niveau attendu

- **Niveau onboarding, exhaustif.** Un nouvel arrivant comprend tout le projet — ce qu'il fait, comment
  on l'installe, comment on s'en sert, comment il est organisé, comment il se comporte en cas
  d'erreur — **sans ouvrir le code**. Une capacité du projet absente de la documentation est un défaut.
- **Jamais de code source.** Aucun extrait du code du projet, aucun détail d'implémentation. Seuls
  sont admis :
  - le **nom** d'un module, d'une classe ou de quelques fonctions, quand il aide à se repérer ;
  - les **commandes que le lecteur doit taper** pour installer ou utiliser l'outil, et les fichiers
    de configuration qu'il doit écrire : c'est de l'usage, pas du code.
- **Ce que fait le projet se décrit à partir de l'écrit qui fait foi** (spécification, documentation
  de référence du projet). Si le code s'en écarte, **signale l'écart** dans ton compte rendu : ne
  documente pas le comportement du code comme s'il était voulu, ne corrige pas le code.

## 2. Structure imposée

Le menu suit cet ordre, toujours :

| Section | Contenu |
|---|---|
| **Introduction** | Ce que fait le projet, pour qui, ce qu'il ne fait pas. Un diagramme d'ensemble. |
| **Démarrage rapide** | Le plus court chemin de l'installation à un premier résultat réel, étape par étape. |
| **Documentation complète** | Une page par sujet : installation détaillée, configuration, usage de chaque capacité, organisation du projet, erreurs et leur résolution. |
| **FAQ** | Les questions et les pannes réelles ou prévisibles, chacune avec sa réponse et un lien vers la page de référence. |
| **Glossaire** | Une ligne par terme, avec un lien vers la page qui l'explique. |

## 3. Règles d'écriture

- **Une information à un seul endroit.** Chaque sujet a une page de référence ; les autres pages y
  renvoient par un lien, elles ne le répètent pas.
- **Diagrammes Mermaid** partout où ils rendent la lecture plus rapide qu'un paragraphe : `flowchart`
  pour un enchaînement ou une architecture, `sequenceDiagram` pour un échange, `stateDiagram-v2`
  pour des états, `erDiagram` pour des données. Un diagramme par idée, quinze nœuds au plus,
  libellés dans la langue de la documentation.
- **Direct.** Va droit au but ; un exemple concret plutôt qu'une généralité (« si le fichier
  d'entrée contient une ligne vide, l'outil s'arrête et nomme la ligne », pas « gestion robuste des
  erreurs »).
- **Chaque terme technique est défini** à sa première apparition et repris dans le glossaire.
- **Encadrés** (`!!! tip`, `!!! warning`, `!!! note`) pour ce qui ne doit pas être manqué ; ne pas
  en abuser.

## 4. Écriture « façon Material for MkDocs »

La documentation s'écrit en Markdown dans `docs/`, configurée par un `mkdocs.yml` au format Material
for MkDocs. Ce format est lu par les deux générateurs possibles (section 5) : la documentation ne
change pas quand on change de générateur.

Le `mkdocs.yml` doit contenir au minimum :

- `theme: name: material`, la langue de la documentation, et les fonctionnalités
  `navigation.footer` (**pied de page** : lien vers la page précédente et la suivante),
  `navigation.sections`, `navigation.top`, `search.highlight`, `content.code.copy`,
  `content.tooltips` ;
- les extensions `admonition`, `pymdownx.details`, `attr_list`, `md_in_html`, `tables`, `abbr`,
  `toc` avec `permalink: true`, et `pymdownx.superfences` avec le bloc `mermaid` déclaré en
  `custom_fences` ;
- un `nav` explicite qui suit la structure de la section 2 ;
- la validation des liens : `validation: links: anchors: warn`.

## 5. Le générateur : fixé par la fiche de tâche

Deux générateurs lisent ce format : **Material for MkDocs** et son successeur **Zensical**.

- **Le générateur et sa version sont fixés par ta fiche de tâche.** S'ils n'y figurent pas,
  arrête-toi et signale-le : ne choisis pas.
- **Fige les versions** dans le fichier de dépendances du projet. Avec Material for MkDocs, garde
  MkDocs en version `<2`, qui lui est incompatible.

## 6. Vérifier avant de rendre la main

- La construction **stricte** passe sans avertissement (`build --strict` du générateur retenu) ;
  cite sa sortie.
- Chaque page du dossier `docs/` figure dans le `nav`, dans l'ordre de la section 2.
- Les diagrammes Mermaid s'affichent dans le site construit (ouvre au moins une page qui en
  contient).
- Le pied de page de navigation apparaît.
- Aucun bloc ne contient de code source du projet.
