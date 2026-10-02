# Questions fréquentes

## Mise en route

??? question "Claude ne se présente pas comme le Tech Leader."
    Vérifiez dans cet ordre :

    1. VS Code a ouvert **la racine du projet**, celle qui contient `.claude\`, et pas un
       sous-dossier ni un dossier parent.
    2. Le fichier `.claude\settings.json` du projet contient bien `{ "agent": "tech-leader" }`, sans
       erreur de syntaxe. Ouvert dans VS Code, un JSON mal formé est souligné en rouge.
    3. Le fichier `C:\Users\<votre-nom>\.claude\agents\tech-leader.md` existe.
    4. Vous avez **redémarré VS Code** après ces corrections : une nouvelle conversation ne suffit
       pas.

??? question "Comment savoir si le socle est bien chargé ?"
    Voir [Installer le kit, étape B](demarrer/installer-le-kit.md#etape-b-verifier).

??? question "J'avais déjà ma propre configuration Claude Code. Que faire ?"
    Faites l'intégration avec l'aide de Claude : voir
    [Installer le kit, étape A](demarrer/installer-le-kit.md#etape-a-la-configuration-personnelle).

## Pendant le travail

??? question "Le Tech Leader est trop pointilleux, il me pose beaucoup de questions."
    Vérifiez d'abord le [niveau de qualité](comprendre/niveaux.md) du document projet. S'il en fait
    trop pour ce niveau, rappelez-le-lui : « on est au niveau `poc`, note-le hors niveau ». Un
    document projet complet et un [besoin bien décrit](travailler/bonnes-pratiques.md#formuler-un-besoin)
    réduisent aussi les questions.

??? question "Mon POC a convaincu, il devient un outil d'équipe. Que faire ?"
    Voir [Changer de niveau](comprendre/niveaux.md#changer-de-niveau).

??? question "Le Tech Leader refuse d'écrire le code lui-même."
    C'est voulu : voir [Ce qu'il ne faut pas faire](travailler/bonnes-pratiques.md#ce-quil-ne-faut-pas-faire).

??? question "Le compte rendu indique `NON FAIT`. Est-ce un échec ?"
    Non : le Developer s'est arrêté faute d'une information, au lieu de deviner. Répondez à la
    question que le Tech Leader vous transmet. Voir
    [En coulisses : le compte rendu](comprendre/coulisses-compte-rendu.md#1-ce-qui-a-ete-fait-avec-un-statut).

??? question "Un agent veut créer un environnement virtuel ou installer un paquet."
    Il doit vous le demander ([règles d'ingénierie](comprendre/regles-ingenierie.md#4-python-toujours-le-venv-du-projet)).
    Acceptez si l'installation correspond à ce qui a été validé en conception.

??? question "Ça consomme beaucoup. Comment surveiller ?"
    `/usage` affiche votre consommation. Le Tech Leader tourne sur Opus, le plus coûteux : vous
    pouvez passer sur Sonnet depuis le nom du modèle, au prix d'une réflexion moins poussée. Voir
    [Le modèle](comprendre/notions.md#le-modele).

??? question "Je me suis trompé, je veux annuler les dernières modifications."
    Voir [Reprendre la main](travailler/session.md#reprendre-la-main). Pour un filet de sécurité
    durable, versionnez le projet avec **Git** : le Tech Leader ne commite jamais sans demande
    explicite.

## Aller plus loin

??? question "Le système sert-il seulement à écrire du code ?"
    Non. La fiche de tâche est volontairement **agnostique** : code, configuration, rédaction de
    documents, investigation. Le Tech Leader peut par exemple piloter une analyse de données ou la
    rédaction d'une documentation technique.

??? question "Puis-je modifier les rôles ou le socle ?"
    Oui : ce sont des fichiers Markdown. Respectez le principe **« une règle à un seul endroit »** :

    - ce qui vaut **partout** va dans le socle ;
    - ce qui décrit **un rôle** va dans son fichier d'agent ;
    - ce qui est **propre à un projet** va dans son document projet.

    Après une modification, demandez à Claude de relire ces fichiers pour y chercher des
    **consignes contradictoires ou répétées**.

??? question "Comment reconstruire cette documentation après modification ?"
    La procédure est dans le `README.md` à la racine du kit.
