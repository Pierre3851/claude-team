---
description: Reprendre un travail interrompu par manque de crédit Claude Code, après avoir constaté l'état réel.
disable-model-invocation: true
---

La conversation s'est arrêtée par manque de crédit Claude Code. Reprends le travail là où il s'est
arrêté, mais **constate d'abord, ne suppose pas** : la coupure a pu survenir au milieu d'une étape.

1. **Retrouve le fil.** Quelle était la tâche, et quelle était la dernière étape engagée ? Si tu n'as
   plus le fil (nouvelle conversation, contexte perdu), recharge-le depuis les fichiers : ta mémoire,
   le `CLAUDE.md` du projet et les documents qu'il désigne, l'état du dépôt Git.

2. **Constate l'état réel de la dernière étape**, preuve à l'appui :
   - fichiers modifiés : complets ou à moitié écrits (`git status`, `git diff`, relecture) ;
   - commande ou traitement lancé : terminé, échoué ou encore en cours (processus, journal) ;
   - sous-agent lancé : son résultat est probablement perdu ; vérifie sur le disque ce qu'il a
     réellement produit, ne le tiens pas pour fait.

3. **Ne refais pas à l'aveugle** une action qui ne se répète pas sans risque : commit, ajout de
   données, envoi, suppression. Vérifie d'abord si elle a déjà eu lieu.

4. **Annonce en deux ou trois lignes** ce que tu as constaté et l'étape par laquelle tu reprends, puis
   **reprends**. Si l'état de la dernière étape est indéterminable ou incohérent, arrête-toi et
   demande-moi plutôt que de deviner.
