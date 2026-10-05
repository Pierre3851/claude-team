# Glossaire

Une ligne par terme, et un lien vers la page qui l'explique.

**ADR** (*Architecture Decision Record*)
:   Courte fiche qui consigne une décision technique et ses alternatives écartées. →
    [Qui fait quoi](travailler/mission.md#phase-par-phase)

**Agent, sous-agent**
:   Instance du modèle dotée d'un rôle ; un sous-agent est lancé par la session principale et repart
    de zéro. → [Notions](comprendre/notions.md#agents-et-sous-agents)

**Architecture (document d')**
:   Comment les pièces de la solution s'assemblent. → [Qui fait quoi](travailler/mission.md#phase-par-phase)

**Backlog**
:   Liste ordonnée des tâches à réaliser. → [Qui fait quoi](travailler/mission.md#phase-par-phase)

**Boucle agentique**
:   Cycle réfléchir → agir → observer, répété jusqu'à la fin de la tâche. →
    [Notions](comprendre/notions.md#claude-code-un-assistant-qui-agit)

**Cadrage**
:   Ce que la nature du projet change dans les décisions techniques ; il figure dans la rubrique
    « Le produit » du document projet. → [Initialiser un projet](demarrer/initialiser-un-projet.md#ce-que-le-tech-leader-va-vous-demander)

**Claude Code**
:   Assistant de programmation d'Anthropic, utilisé ici dans VS Code via son extension. →
    [Notions](comprendre/notions.md#claude-code-un-assistant-qui-agit)

**`CLAUDE.md`**
:   Fichier d'instructions chargé à chaque conversation : le socle (personnel) et le document projet.
    → [Notions](comprendre/notions.md#le-prompt-systeme-et-les-fichiers-claudemd)

**Commande personnalisée**
:   Prompt enregistré, lancé en tapant `/<nom>`. → [Piloter une session](travailler/session.md#avant-et-apres-un-compactage)

**Compactage**
:   Résumé de la conversation quand le contexte se remplit. → [Notions](comprendre/notions.md#le-contexte),
    [Piloter une session](travailler/session.md#avant-et-apres-un-compactage)

**Compte rendu**
:   Rapport du Developer au Tech Leader, en six sections. →
    [En coulisses](comprendre/coulisses-compte-rendu.md)

**Contexte**
:   Tout ce que le modèle a sous les yeux ; il n'a pas d'autre mémoire. →
    [Notions](comprendre/notions.md#le-contexte)

**Critère d'acceptation**
:   Condition vérifiable par oui ou non : *quand <déclencheur>, le système doit <réponse>*. →
    [En coulisses](comprendre/coulisses-fiche-de-tache.md#5-etat-final-attendu-binaire-et-verifiable)

**Developer**
:   Rôle exécutant : il code, teste et rend compte au Tech Leader. → [L'équipe](comprendre/equipe.md)

**Document projet**
:   Le `CLAUDE.md` d'un projet, en cinq rubriques. →
    [Initialiser un projet](demarrer/initialiser-un-projet.md#ce-que-le-tech-leader-va-vous-demander)

**Documentation de référence**
:   L'écrit qui fait foi pour un projet ; c'est là que se lit le résultat attendu des tests. →
    [Règles d'ingénierie](comprendre/regles-ingenierie.md#5-tests-pas-de-test-unitaire-lattendu-vient-de-lecrit)

**Écart**
:   Différence entre une consigne et la documentation ; elle se signale, jamais ne se tranche en
    silence. → [En coulisses](comprendre/coulisses-compte-rendu.md#4-sources-et-ecarts)

**Effort**
:   Quantité de réflexion accordée au modèle. → [Notions](comprendre/notions.md#leffort)

**Fiche de tâche**
:   Consigne en cinq blocs ; aucun travail ne démarre sans elle. →
    [En coulisses](comprendre/coulisses-fiche-de-tache.md)

**Hook**
:   Script exécuté automatiquement par Claude Code, indépendamment du modèle. Le kit n'en installe
    pas.

**Hors niveau**
:   Point noté en une ligne, sans être traité, car il ne compte qu'à un niveau supérieur. →
    [Niveaux](comprendre/niveaux.md#hors-niveau-noter-sans-traiter)

**Hors-périmètre**
:   Ce qu'on ne touche pas. → [Initialiser un projet](demarrer/initialiser-un-projet.md#ce-que-le-tech-leader-va-vous-demander)

**Injection de prompt**
:   Texte piégé qui se fait passer pour une instruction. → [Socle, règle 5](comprendre/socle.md#5-securite-et-confidentialite)

**Invariant**
:   Propriété du produit qui ne doit jamais devenir fausse. → [Exemple](exemple.md#le-document-projet)

**Livrable**
:   Document ou résultat produit à une étape, rangé à l'emplacement prévu par le document projet.

**Mode de permission**
:   Ce que Claude Code peut faire sans vous demander. → [Notions](comprendre/notions.md#les-permissions)

**Modèle**
:   Le réseau de neurones : Opus pour le Tech Leader, Sonnet pour le Developer. →
    [Notions](comprendre/notions.md#le-modele)

**Niveau de qualité**
:   `poc`, `script-ponctuel`, `outil-perso`, `interne` ou `release` : il règle la finesse du
    travail. → [Niveaux](comprendre/niveaux.md)

**Porte de validation**
:   Point d'arrêt où l'équipe attend votre décision. → [Vos moments d'attention](travailler/attention.md#les-portes-de-validation)

**Prompt système**
:   Instructions reçues par le modèle avant toute conversation. →
    [Notions](comprendre/notions.md#le-prompt-systeme-et-les-fichiers-claudemd)

**Règles d'ingénierie**
:   Texte fixe commun aux projets du kit : niveau de qualité, venv, tests, erreurs, sécurité du
    code. → [Règles d'ingénierie](comprendre/regles-ingenierie.md)

**Remontée**
:   Problème que le Tech Leader vous soumet au lieu de le trancher seul. →
    [Vos moments d'attention](travailler/attention.md#les-remontees)

**Repli silencieux**
:   Valeur « par défaut » utilisée sans le dire ; interdit. →
    [Socle, règle 2](comprendre/socle.md#2-jamais-de-valeur-par-defaut-ni-de-repli-silencieux)

**Session**
:   Une conversation dans l'extension. Une modification de configuration demande de redémarrer
    VS Code. → [Installer le kit](demarrer/installer-le-kit.md#etape-b-verifier)

**`settings.json`**
:   Réglages techniques de Claude Code. → [Notions](comprendre/notions.md#les-reglages-settingsjson)

**Skill**
:   Fichier de consignes que Claude Code charge seulement quand la tâche en a besoin ; le kit en
    fournit un, la charte de documentation. → [Installer le kit](demarrer/installer-le-kit.md#ce-que-vous-venez-dinstaller)

**Socle**
:   Votre `CLAUDE.md` personnel : cinq règles pour tout usage de Claude Code. → [Socle](comprendre/socle.md)

**Spécification**
:   Description validée du besoin, avec ses critères d'acceptation. →
    [Qui fait quoi](travailler/mission.md#phase-par-phase)

**Tech Leader**
:   Rôle de pilotage : il dialogue avec vous, décide, délègue et vérifie, sans jamais coder. →
    [L'équipe](comprendre/equipe.md)

**Test fonctionnel, test unitaire**
:   Le premier vérifie une capacité visible de l'extérieur (seul admis) ; le second une fonction
    interne (proscrit). → [Règles d'ingénierie](comprendre/regles-ingenierie.md#5-tests-pas-de-test-unitaire-lattendu-vient-de-lecrit)

**Token**
:   Unité de texte (environ ¾ de mot) ; la consommation se compte en tokens. →
    [Notions](comprendre/notions.md#les-tokens)

**venv**
:   Environnement Python isolé propre à un projet. → [Règles d'ingénierie](comprendre/regles-ingenierie.md#4-python-toujours-le-venv-du-projet)
