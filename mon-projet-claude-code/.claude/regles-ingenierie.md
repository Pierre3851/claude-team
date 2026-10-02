# Règles d'ingénierie — texte fixe

Ce fichier est **commun à tous les projets** organisés avec le duo tech-leader / developer. Il est
chargé par le `CLAUDE.md` du projet et complète le socle personnel (`~/.claude/CLAUDE.md`).
**Ne le modifie pas pour un projet** : ce qui est propre au projet va dans les rubriques du
`CLAUDE.md`.

## 1. Niveau de qualité — proportionner l'effort

La rubrique « Le produit » du `CLAUDE.md` déclare un **niveau de qualité**. Il fixe la **profondeur**
du travail — formalisme, recherche, tests, robustesse — et jamais son **honnêteté**. Trop de finesse
est un défaut au même titre que trop peu : sur un POC, la rigueur d'une release est du temps perdu
et une démo retardée.

| | `poc` | `script-ponctuel` | `outil-perso` | `interne` | `release` |
|---|---|---|---|---|---|
| **Pour quoi** | Démontrer qu'une idée est faisable. Jetable. | Produire un résultat une fois (migration, extraction). Code jeté ensuite. | Outil utilisé par son auteur, dans la durée. | Application utilisée et maintenue par une équipe. | Livré à un client externe. |
| **Déroulé** | Une seule porte : besoin et approche en quelques lignes. | Une porte : spec courte et méthode de contrôle du résultat. | Deux portes : spec, puis conception et backlog. | Trois portes. | Trois portes, revue finale détaillée. |
| **Écrits** | README : lancer la démo. | Spec courte, rapport de contrôle. | Spec, décisions clés en quelques lignes (version, source), backlog. | Spec, architecture, ADR des choix structurants, backlog. | Spec, architecture, ADR de chaque choix, backlog, doc utilisateur. |
| **Choix d'outils** | Premier outil mature qui convient ; ses limites lues dans sa doc ; pas de comparatif. | Idem `poc`. | Comparatif court (deux candidats). | Comparatif. | Comparatif complet : maturité, licence, support. |
| **Tests** | Le scénario de démo, de bout en bout. | Cas représentatifs et contrôle de cohérence du résultat (comptages, totaux). | Critères d'acceptation : cas nominaux et entrées invalides prévisibles. | Tous les critères et les cas limites. | Tous les critères, cas limites, non-régression. |
| **Erreurs** | Arrêt avec un message clair. | Arrêt avec un message clair ; aucune donnée perdue. | Messages compréhensibles par l'utilisateur. | Idem, plus journalisation. | Messages destinés au client, journalisation, reprise sur erreur. |
| **Non-fonctionnel** (perf, déploiement, maintenance) | Hors sujet. | Tenir le volume réel. | Le strict utile. | Pris en compte. | Exigé et vérifié. |

- **Ce qui ne varie jamais** : le socle et les sections 2 à 6 s'appliquent à tous les niveaux ;
  seule l'**étendue** des tests (section 5) suit le tableau. Un compte rendu reste honnête : un POC
  non testé se dit non testé.
- **Ce qui dépasse le niveau se note, ne se traite pas** : une ligne marquée « hors niveau » dans le
  livrable ou le compte rendu — ni question, ni tâche, ni porte supplémentaire.
- **Niveau absent ou ambigu : arrête-toi et demande.**
- **Changer de niveau est un recadrage explicite.** Ce qui a été produit au niveau inférieur
  n'hérite d'aucune garantie : il est à réévaluer, et tu le signales.

## 2. Documentation des outils : la version en place

Avant d'écrire du code qui utilise une bibliothèque, un outil, une API, un format de configuration ou
une commande CLI, **vérifie la version réellement installée** dans le projet (fichier de
dépendances, `--version`, paquet installé) et lis la documentation de **cette** version. Les
fondamentaux du langage et le code du projet lui-même ne se cherchent pas sur le web.

## 3. Erreurs dans le code : jamais avalées

Application au code de la règle 2 du socle :

- pas de `except: pass`, `catch {}`, `|| true`, `2>/dev/null` qui avale une erreur ;
- pas de `or "défaut"`, `?? fallback`, `.get(k, valeur)` qui masque une donnée absente ;
- une donnée manquante produit une **erreur explicite et bruyante**, jamais un résultat dégradé.

Un code de retour 0 n'est pas une preuve : cite la sortie réelle.

## 4. Python : toujours le venv du projet

- **Appelle l'interpréteur par son chemin**, sans dépendre d'une activation :
  `.venv/Scripts/python.exe` (Windows) ou `.venv/bin/python` (Linux/macOS). L'état du shell ne
  persiste pas entre deux appels de l'outil Bash : un `activate` est **perdu** au suivant.
- Même règle pour les paquets : `.venv/Scripts/python.exe -m pip install ...`, jamais `pip` nu.
- Si le venv n'existe pas ou porte un autre nom, **cherche-le** (`.venv`, `venv`, `pyproject.toml`,
  `uv.lock`, `requirements.txt`) ; si tu ne le trouves pas, **demande** avant d'en créer un ou
  d'installer quoi que ce soit — jamais dans le Python global.
- Exception unique : un script jetable dans le répertoire scratchpad, sans dépendance externe.

## 5. Tests : pas de test unitaire, l'attendu vient de l'écrit

**N'écris aucun test unitaire** : un test qui appelle directement une fonction, une méthode ou une
classe **interne**, isolée de ses collaborateurs réels, en général avec des mocks, stubs ou
doublures. Si tu es sur le point de créer un `test_<module>.py`, `<Classe>Test.java` ou
`<module>.spec.ts` qui reflète la structure du code, **arrête-toi**.

Seuls deux niveaux sont acceptés :

- **test fonctionnel** — exerce une **capacité observable** par l'**interface publique** du
  composant (CLI, API, fichier d'entrée/sortie, événement), sans doublure sur la logique testée ;
- **test de bout en bout** — traverse la chaîne réelle, de l'entrée utilisateur au résultat final.

**Toujours sur des données fabriquées**, jamais sur de vraies données. **Teste avant de rendre la
main** : livrer sans avoir exercé ce qu'on a écrit, c'est déléguer la découverte de la panne.

**L'attendu se lit dans l'écrit** — la documentation de référence ou la spécification du projet —,
jamais dans le code, jamais dans la sortie d'une exécution :

- **avant d'écrire un test, cite sa source** : fichier + section ou ligne. Un test sans source citée
  n'est pas recevable ;
- **n'exécute jamais le code pour découvrir l'attendu** : inscrire la sortie actuelle comme
  référence grave le comportement actuel, bugs compris ;
- **si l'écrit ne dit rien** sur le cas à couvrir : **arrête-toi et demande**.

**Un test qui échoue ne se modifie jamais pour passer.** Dis, preuve à l'appui, lequel est en cause :
le **code** (il se corrige), la **spécification** (fausse, ambiguë ou incomplète : tu le remontes,
tu ne tranches pas), ou le **test** (il traduit mal la spec : tu cites la ligne et tu expliques
l'écart **avant** d'y toucher). Assouplir une assertion, élargir une tolérance, retirer un cas,
mettre en `skip` : ce sont des **modifications du contrat**, qui exigent un accord explicite.

**Cas limites et erreurs** — entrée vide, absente, malformée, hors bornes, permission refusée — se
testent **par l'entrée publique**, avec une donnée fabriquée pour les provoquer : c'est le seul moyen
de vérifier que l'erreur remonte réellement jusqu'à l'utilisateur.

## 6. Sécurité du code

**Aucune vulnérabilité introduite** (OWASP Top 10). Les secrets vivent hors du code, dans `.env` ou
l'équivalent prévu par le projet, et ce fichier n'est jamais versionné.
