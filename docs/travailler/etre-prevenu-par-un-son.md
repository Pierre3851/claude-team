# Être prévenu par un son

Quand Claude Code travaille, vous allez voir autre chose et vous ne savez pas quand il a fini, ni
quand il attend votre réponse. Un son Windows règle cela : vous n'avez plus à surveiller l'écran.

| Son | Quand il retentit |
|---|---|
| `tada.wav` | Claude a **fini de répondre**. |
| `Windows Notify Messaging.wav` | Claude **vous attend** : une autorisation à accorder, ou une question à laquelle répondre. |

!!! info "C'est une option"
    Rien de tout cela ne s'installe avec le kit : le script `hooks\jouer-son.ps1` est copié avec
    le reste, mais il ne fait **rien** tant que vous ne l'avez pas déclaré à l'étape 2. Il faut
    Windows et [Git for Windows](../demarrer/installer-claude-code.md#2-installer-git-for-windows),
    déjà prérequis du kit.

Le mécanisme s'appelle un **hook** : un script que Claude Code exécute automatiquement à un moment
précis (ici : la fin d'une réponse, ou une demande d'autorisation), indépendamment du modèle.

## Étape 1 — Copier le script

Dans l'Explorateur Windows, copiez `hooks\jouer-son.ps1` du dossier `C-Users-votre-nom-.claude\` du
kit vers `C:\Users\<votre-nom>\.claude\hooks\`. Créez le dossier `hooks` s'il n'existe pas.

## Étape 2 — Déclarer les deux sons

Ouvrez `C:\Users\<votre-nom>\.claude\settings.json`. Le bloc `hooks` se place **à l'intérieur**
de l'accolade principale du fichier (la première `{` et la dernière `}`), **après la dernière clé
existante**, en ajoutant une **virgule** après cette clé. Avec le `settings.json` fourni par le
kit, le fichier devient :

```json
{
  "model": "opus",
  "effortLevel": "medium",
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"$USERPROFILE/.claude/hooks/jouer-son.ps1\" -Son \"tada.wav\"",
            "timeout": 15,
            "statusMessage": "Signal sonore : travail termine..."
          }
        ]
      }
    ],
    "PermissionRequest": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"$USERPROFILE/.claude/hooks/jouer-son.ps1\" -Son \"Windows Notify Messaging.wav\"",
            "timeout": 15,
            "statusMessage": "Signal sonore : autorisation demandee..."
          }
        ]
      }
    ]
  }
}
```

- **Rien à remplacer** dans ce bloc : `$USERPROFILE` désigne votre dossier utilisateur, le chemin se
  trouve tout seul.
- Si `settings.json` contient **déjà** une clé `hooks`, ne créez pas une seconde clé : fusionnez.
  Chaque événement (`Stop`, `PermissionRequest`) ne doit apparaître **qu'une fois** ; ajoutez
  votre bloc à la liste existante de l'événement.
- Si votre fichier contient d'autres clés que `model` et `effortLevel`, gardez-les : le bloc
  `hooks` va après la dernière, précédée d'une virgule, et **sans virgule** après lui s'il
  est le dernier.

## Étape 3 — Vérifier

[Redémarrez VS Code après toute modification de configuration](../demarrer/installer-le-kit.md),
puis envoyez n'importe quel message à Claude : à la fin de sa réponse, vous
devez entendre le son `tada`.

### Rien ne sonne ?

**1. Testez le son à la main.** C'est la seule commande à taper vous-même. Ouvrez un terminal
PowerShell (dans VS Code : menu **Terminal** puis **Nouveau terminal**) et tapez :

```text
(New-Object System.Media.SoundPlayer 'C:\Windows\Media\tada.wav').PlaySync()
```

Si vous n'entendez rien ici, le problème vient de Windows (volume, sortie audio), pas du kit.

**2. Demandez à Claude de lire le journal.** Le script note chaque son joué dans
`journal-sons.log`, à côté de lui. Demandez par exemple :

```text
Lis les 5 dernières lignes de ~/.claude/hooks/journal-sons.log et dis-moi ce qu'elles indiquent
```

| Ce que vous constatez | Ce que cela veut dire |
|---|---|
| Aucune ligne (ou fichier absent) | Le hook n'a jamais été appelé : `settings.json` est invalide ou le bloc est mal placé, ou VS Code n'a pas été redémarré. |
| Une ligne de début **sans** ligne « fin lecture » | La lecture a été **interrompue**. |
| Une ligne de début **et** « fin lecture », mais rien entendu | Le script a fonctionné : c'est un problème de sortie audio. |

Le journal est renommé automatiquement au-delà de 500 000 octets.

## Changer de son

Les sons sont les fichiers `.wav` du dossier `C:\Windows\Media`. Dans le bloc de l'étape 2, remplacez
le nom après `-Son` (par exemple `\"tada.wav\"`) par celui d'un autre fichier de ce dossier, puis
redémarrez VS Code. Attention : les `Alarm01` à `Alarm10` durent plusieurs secondes.

Pour lister les sons disponibles, demandez à Claude : « Liste les fichiers .wav de
C:\Windows\Media ».

## Bon à savoir

- **Chaque fin de tour sonne**, pas une fois par tâche. Quand le Tech Leader attend un sous-agent
  lancé en arrière-plan, plusieurs sons peuvent retentir pour un seul travail.
- **Le hook d'autorisation ne décide rien.** Un hook qui n'écrit rien en sortie n'approuve rien :
  la fenêtre d'autorisation s'affiche normalement. Le script n'écrit jamais en sortie, et ne doit
  jamais le faire, sans quoi il pourrait répondre à votre place.
- **Pourquoi pas l'événement `Notification` ?** Selon les mesures de l'auteur du kit, il ne s'est
  jamais déclenché dans l'extension VS Code. La documentation officielle ne le dit pas : c'est un
  constat, pas un fait documenté.
- **Pourquoi pas de hook sur l'outil de question ?** Selon les mesures de l'auteur du kit,
  l'événement d'autorisation a aussi sonné quand Claude lui posait une question, mais dans une
  session où les outils ne demandaient pas d'autorisation (mode « bypass ») : ce point n'est pas
  documenté, et il n'a pas été vérifié dans les autres modes. Un hook `PreToolUse` sur cet outil, essayé puis retiré, ne se
  déclenchait pas à chaque question, et quand les deux se déclenchaient ensemble, la lecture était
  interrompue.
- **Pourquoi pas `"async": true` ?** La documentation officielle indique que `Stop` et
  `PermissionRequest` s'exécutent toujours en synchrone : le réglage ne servirait à rien.
- Le son passe écran verrouillé, tant que l'ordinateur est éveillé. En veille, Claude Code ne
  tourne plus : aucun son.

??? abstract "Sources"
    - Événements `Stop` et `PermissionRequest`, format de la configuration `hooks`, sortie d'un hook
      (« staying silent doesn't approve it »), section « Run hooks in the background » :
      [code.claude.com/docs/en/hooks](https://code.claude.com/docs/en/hooks)
    - Constats sur `Notification`, `PreToolUse` et `PermissionRequest` (sur les questions) : mesures de l'auteur du kit (extension VS Code,
      Windows 11, Windows PowerShell 5.1), non documentées.
