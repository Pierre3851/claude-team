---
description: Avant un compactage — mettre à jour mémoire et documents du projet, puis commiter, pour que rien ne se perde.
disable-model-invocation: true
---

Je vais compacter la conversation. Ce qui n'existe que dans cet échange sera résumé, donc en partie
perdu. Mets d'abord en sécurité ce qui doit durer, puis rends-moi la main. **Ne commence aucun
nouveau travail.**

1. **Fais l'inventaire** de ce qui, depuis le début de la conversation ou depuis le dernier
   compactage, n'existe que dans l'échange : décisions, réponses à tes questions, corrections que je
   t'ai données, avancement, points ouverts, opérations encore en cours.

2. **Range chaque élément à sa place :**
   - ce qui concerne le projet (avancement, décisions, précisions du besoin, points ouverts) → les
     documents du projet prévus pour cela. Si le `CLAUDE.md` du projet désigne leurs emplacements,
     respecte-les ;
   - une règle durable propre au projet → **propose**-la pour le `CLAUDE.md` du projet, que tu ne
     modifies qu'avec mon accord ;
   - une préférence ou une correction sur ma façon de travailler → ta **mémoire**.

   Un élément sans emplacement évident : demande-moi, n'invente pas de fichier.

3. **Commite.** L'appel de cette commande vaut demande explicite de commit, pour ce commit-là
   uniquement. Si le dossier est un dépôt Git : liste les fichiers modifiés, vérifie qu'aucun secret
   ni fichier ignoré (`.env`…) n'en fait partie, puis commite avec un message qui résume l'état du
   travail. Ne pousse pas. Si ce n'est pas un dépôt Git, dis-le et n'en crée pas.

4. **Rends compte en quelques lignes** : ce qui a été écrit et où, l'identifiant du commit, ce qui
   n'a pas pu être sauvegardé et pourquoi. Termine par une instruction de compactage prête à copier,
   qui dit au résumé sur quoi insister :

   `/compact Garder : <tâche en cours et son état>, <questions en attente de réponse>`
