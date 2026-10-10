# Exemple complet

Cette page suit une petite mission **fictive** du début à la fin. Les échanges sont **illustratifs**
et raccourcis : ils montrent la forme du travail, ce ne sont pas des sorties réelles.

!!! abstract "Le scénario"
    Camille tient les comptes d'une association. Chaque mois, elle exporte les dépenses de la banque
    en fichier CSV, puis calcule à la main le total par catégorie dans un tableur. Elle voudrait
    automatiser ce calcul.

## Le document projet

Camille crée le dossier `D:\projets\depenses`, y recopie le modèle, y dépose la description du format
d'export fournie par sa banque, ouvre le dossier dans VS Code et tape la commande
[`/nouveau-projet`](demarrer/initialiser-un-projet.md#etape-3-initialiser-le-projet-avec-le-tech-leader).
Elle décrit son besoin en deux phrases, niveau `outil-perso`. Rubrique après rubrique, le Tech Leader lui pose ses questions et propose le texte. Voici le
`CLAUDE.md` obtenu :

```markdown
@.claude/regles-ingenierie.md

# Document projet — depenses

## 1. Le produit

Script Python qui calcule, à partir de l'export CSV mensuel de la banque,
le total des dépenses par catégorie. Utilisé par une seule personne, une fois par mois.

**Niveau de qualité : `outil-perso`**

> **Outil personnel — à lire avant tout arbitrage technique.**
>
> Outil local, un seul utilisateur, quelques centaines de lignes par mois.
>
> **Ce que cela change dans l'implémentation** : pas d'interface graphique, pas de base
> de données, pas de dépendance externe si la bibliothèque standard suffit.

- **Aucune donnée perdue** — toute ligne du fichier d'entrée est soit comptée,
  soit signalée en erreur ; jamais ignorée en silence.
- **Le fichier d'entrée n'est jamais modifié.**

## 2. Documentation de référence

**`docs/format-export-banque.md`** décrit le format du CSV exporté par la banque
(colonnes, séparateur, encodage, format des montants). Elle fait **cadre**.

## 3. Emplacement des livrables

| Livrable      | Emplacement                          |
|---------------|--------------------------------------|
| Spécification | `docs/specification.md`              |
| Décisions     | `docs/decisions.md`                  |
| Backlog       | `docs/backlog.md`                    |
| Code          | `src/`                               |
| Tests         | `tests/`                             |

## 4. Conventions et contraintes

- **Environnement d'exécution** : Windows 11, Python 3.13, venv `.venv` à la racine.
- **Nommage, style, langue** : noms de variables en français, messages d'erreur en français.
- **Versionnement** : Git ; tout est versionné sauf `.env`, `.venv/` et `donnees/`.

## 5. Hors-périmètre

- **Les vrais relevés bancaires** (`donnees/`) — ne jamais les lire ni les utiliser
  pour les tests ; les tests utilisent des fichiers fabriqués.
- **La catégorisation automatique des dépenses** — la catégorie est fournie par la
  banque ; si une tâche semble exiger de la deviner, c'est la tâche qui est mal posée.
```

Remarquez le **niveau de qualité**, qui fixe le déroulé à deux portes, les **invariants** formulés
comme des interdictions vérifiables, et le hors-périmètre qui protège les vraies données. Au niveau
`outil-perso`, il n'y a ni document d'architecture ni ADR : les décisions clés tiennent dans un seul
fichier.

## Phase 1 — Clarification

!!! quote "Camille"
    Je voudrais un script qui me donne le total de mes dépenses par catégorie à partir de l'export
    CSV de la banque.

!!! quote "Tech Leader (extrait)"
    J'ai lu `docs/format-export-banque.md`. Avant d'aller plus loin, j'ai besoin de trancher quatre
    points :

    1. **Sortie** : où voulez-vous le résultat ? À l'écran, dans un nouveau fichier CSV, ou les deux ?
    2. **Remboursements** : le format prévoit des montants positifs (crédits). Faut-il les
       **déduire** du total de leur catégorie, les **ignorer**, ou les **lister à part** ?
    3. **Ligne sans catégorie** : le format ne dit pas si la colonne peut être vide. Que doit faire le
       script si c'est le cas ?
    4. **Montant illisible** (par exemple `12,5O` avec la lettre O) : arrêter tout, ou continuer en
       signalant la ligne ?

    Point de vigilance : votre invariant « aucune donnée perdue » exclut d'ignorer une ligne en
    silence. Pour la question 4, je recommande de **s'arrêter** avec un message qui nomme la ligne.
    Un total calculé sur des données partielles aurait l'air juste tout en étant faux.

Camille répond. Le Tech Leader rédige `docs/specification.md`, qui contient notamment ces **critères
d'acceptation** :

```markdown
- CA-1 — Quand on lance le script sur un export valide, il crée `totaux-AAAA-MM.csv`
  contenant une ligne par catégorie et son total, et affiche ce même tableau à l'écran.
- CA-2 — Quand une ligne a une catégorie vide, elle est comptée dans la catégorie
  « Non catégorisé ».
- CA-3 — Quand un montant est illisible, le script s'arrête sans créer de fichier,
  affiche « Montant illisible ligne N : <valeur> » et se termine avec un code différent de 0.
- CA-4 — Les crédits (montants positifs) sont déduits du total de leur catégorie.
```

!!! success "🚦 Porte 1"
    Camille relit, corrige un détail (elle veut aussi le **nombre d'opérations** par catégorie), puis
    valide.

## Phases 2 et 3 — Conception et planification

Au niveau `outil-perso`, le Tech Leader compare **deux candidats**, en lisant leur documentation :
le module **`csv`** de la bibliothèque standard de Python, et la bibliothèque **pandas**. Il consigne
son choix en quelques lignes dans `docs/decisions.md` :

```markdown
## Lecture du CSV — module csv de la bibliothèque standard

Python 3.13 — https://docs.python.org/3.13/library/csv.html
Capacités vérifiées : séparateur configurable (`delimiter=";"`), lecture par nom de
colonne (`DictReader`). Limite : ne convertit pas les montants « 1 234,56 », conversion
à écrire.
Écarté : pandas, dépendance lourde et injustifiée pour quelques centaines de lignes.

Hors niveau — Les montants au format anglais (`1,234.56`) ne sont pas gérés : la banque
n'exporte qu'au format français.
```

Puis il rédige le backlog, de trois tâches :

1. Lire l'export et calculer les totaux (CA-1, CA-2, CA-4).
2. Rejeter un montant illisible (CA-3).
3. Tests fonctionnels sur fichiers fabriqués couvrant CA-1 à CA-4.

!!! success "🚦 Porte 2"
    Camille n'a pas à juger le code. Elle vérifie la **conséquence** du choix (« aucune
    installation ») et l'ordre des tâches, puis valide.

Remarquez la ligne **« Hors niveau »** : le Tech Leader a vu le problème, mais il ne le transforme ni
en question ni en tâche, puisqu'il ne compte pas pour un outil personnel.

## Une fiche de tâche

Voici la fiche de la tâche n°2, telle que le Developer la reçoit :

```markdown
## Objectif
Le script doit refuser un export contenant un montant illisible, en nommant la ligne
fautive, sans produire de fichier de sortie.

## Préalables
- Tâche 1 terminée et validée : `src/totaux.py` calcule les totaux d'un export valide.
- Environnement : `.venv` à la racine, Python 3.13.

## État actuel (constaté)
- `src/totaux.py`, fonction `lire_montant` (ligne 18) : la conversion d'un montant
  illisible lève une `ValueError` non interceptée ; le script s'arrête avec une trace
  Python brute (constaté en lançant le script sur `tests/donnees/montant-illisible.csv`).
- Aucun fichier de sortie n'est créé dans ce cas (constaté).

## À faire / à ne pas faire
- À faire : intercepter le montant illisible et produire le message et le code
  de sortie décrits ci-dessous.
- NE PAS modifier le calcul des totaux, ni le format du fichier de sortie.
- NE PAS toucher au dossier `donnees/` (vraies données, hors périmètre).

## État final attendu
- Quand on lance `.venv\Scripts\python.exe src\totaux.py tests\donnees\montant-illisible.csv`,
  le script affiche exactement « Montant illisible ligne 4 : 12,5O »
  et se termine avec un code de sortie différent de 0.
  Vérification : lancer la commande, puis afficher `$LASTEXITCODE`.
- Après cette commande, aucun fichier `totaux-*.csv` n'existe dans le dossier courant.
  Vérification : lister le dossier.
- Source de l'attendu : `docs/specification.md`, CA-3.
```

Le Tech Leader y joint l'extrait de la spécification (CA-3), le lien vers la documentation du module
`csv`, un rappel du cadrage et le **niveau de qualité** (`outil-perso`). Grâce à ce niveau, le
Developer sait qu'il doit des messages compréhensibles par Camille, mais ni journalisation ni reprise
sur erreur.

## Phase 4 et 5 — Réalisation et validation

Le compte rendu du Developer, en résumé :

| Étape | Statut |
|---|---|
| Interception du montant illisible | **FAIT ET VÉRIFIÉ** : sortie citée « Montant illisible ligne 4 : 12,5O », code de sortie 1 |
| Aucun fichier de sortie créé | **FAIT ET VÉRIFIÉ** : listing du dossier cité |

Dans la section **« Mon avis »**, il ajoute :

> La spécification ne dit pas ce qui se passe pour un montant **vide**. Actuellement, il est traité
> comme illisible. À confirmer.

Le Tech Leader fait vérifier le résultat par une **instance neuve** du Developer, en lecture seule :
conforme. Puis il **remonte la question** à Camille au lieu de trancher seul. Camille confirme, et la
réponse est ajoutée à la spécification (CA-5).

## Phase 6 — Clôture

La synthèse finale rappelle ce qui est livré, comment le lancer, et les **limites** : par exemple,
un changement de format de l'export par la banque cassera le script, mais avec un message
explicite. Camille essaie le script sur un fichier fabriqué, puis sur son vrai relevé, et déclare la
mission terminée.

!!! tip "Ce qu'il faut retenir de l'exemple"
    - Les questions du Tech Leader portaient sur des **choix métier** que seule Camille pouvait faire.
    - Chaque critère se vérifie par une **commande** et un **résultat observable**.
    - Le doute du Developer (montant vide) **n'a pas été tranché en silence** : il est remonté
      jusqu'à Camille et a enrichi la spécification.
