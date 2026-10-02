@.claude/regles-ingenierie.md

# Document projet — <nom du projet>

<!-- Ce fichier contient UNIQUEMENT ce qui est propre à ce projet. Il est rempli par le Tech Leader
     avec l'utilisateur lors de la première conversation. Ce qui est commun est ailleurs :
       - le socle personnel : ~/.claude/CLAUDE.md
       - les rôles : ~/.claude/agents/
       - les règles d'ingénierie communes (texte fixe, importé par la première ligne de ce
         fichier) : .claude/regles-ingenierie.md
     Ces commentaires ne sont pas transmis au modèle : ils peuvent rester. -->

Ce document suit un contrat de **cinq rubriques**. Si l'une d'elles ne répond pas à ta question,
**arrête-toi et demande** : n'invente ni chemin, ni nom de fichier, ni convention.

## 1. Le produit

<!-- Une à trois phrases : ce que fait ce projet, et pour qui. Pas d'historique, pas de feuille
     de route. -->

<Ce que fait le projet, pour qui.>

<!-- UNE valeur parmi poc, script-ponctuel, outil-perso, interne, release : voir la section
     « Niveau de qualité » des règles d'ingénierie. Vide ou deux valeurs : la mission s'arrête. -->

**Niveau de qualité : `<poc | script-ponctuel | outil-perso | interne | release>`**

<!-- Le cadrage : ce que le niveau ne dit pas à lui seul (contexte, contraintes fortes) et ce que
     cela change concrètement dans les décisions. À relire avant tout arbitrage technique. -->

> **Cadrage.** <Le contexte et les contraintes fortes.>
>
> **Ce que cela change** : <la conséquence pratique sur l'implémentation.>

<!-- Invariants : ce qui ne doit jamais devenir faux, quelle que soit la tâche. Formuler chaque
     invariant comme une interdiction vérifiable, pas comme une intention. -->

- **<Invariant>** — <formulation vérifiable.>

## 2. Documentation de référence

<!-- L'écrit qui fait foi : cahier des charges, format de données, règles métier, API. C'est là que
     se lit le résultat attendu des tests. S'il n'y en a aucune, l'écrire franchement : « Ce projet
     ne désigne aucune documentation de référence. » -->

**`<chemin>`** décrit <ce qu'elle décrit>. Elle fait **cadre** : tout écart entre une consigne et
elle se signale explicitement (ce que dit la consigne, ce que dit la doc, l'impact), jamais ne se
tranche en silence.

<!-- Nommer ici les fichiers piégeux : ceux dont le nom ressemble à un livrable et qu'il ne faut
     jamais écraser. -->

## 3. Emplacement des livrables

<!-- Une ligne par livrable que prévoit le niveau de qualité. Chaque chemin doit être tranché :
     « à définir » bloque la mission, et c'est voulu. -->

| Livrable | Emplacement |
|---|---|
| Spécification | `<chemin>` |
| Backlog | `<chemin>` |
| <Architecture, ADR, décisions… selon le niveau> | `<chemin>` |

Un livrable d'un autre type : **arrête-toi et demande où il va.**

## 4. Conventions et contraintes

<!-- Uniquement ce qu'on ne peut pas deviner en lisant le projet. Pas les bonnes pratiques
     générales : elles sont dans le socle et les règles d'ingénierie. -->

- **Environnement d'exécution** : <OS, version de Python, venv ; et où le code s'exécute
  réellement, si ce n'est pas ce poste.>
- **Nommage, style, langue** : <ce qui s'écarte de l'usuel.>
- **Versionnement** : <Git ou non ; ce qui est versionné et ce qui ne l'est pas.>

## 5. Hors-périmètre

<!-- Ce qu'on ne touche JAMAIS ici, et ce qui n'est pas l'objectif même si ça en a l'air. Chaque
     point doit permettre à un exécutant sans contexte de savoir s'arrêter. -->

- **<Ce qu'on ne modifie pas>** — <et ce qu'on fait à la place.>
- **<Ce qui n'est pas l'objectif>** — <si une tâche semble l'exiger, la tâche est mal posée.>
