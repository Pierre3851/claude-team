# Vos moments d'attention

L'équipe s'arrête pour **vous attendre** dans quatre cas seulement. Tant que vous n'avez pas répondu,
rien n'avance. Le reste du temps, elle travaille seule. Vous n'intervenez de vous-même que face à
quelques [signaux d'alerte](#quand-intervenir-de-vous-meme).

| Moment | Comment le reconnaître | Ce qu'on attend de vous | Le piège |
|---|---|---|---|
| 🟡 **Une question** | Le Tech Leader termine son message par une ou plusieurs questions, parfois avec des choix à cocher. | Répondre précisément. | Répondre au hasard pour avancer. |
| 🔴 **Une porte de validation** | Il présente un livrable (spécification, conception, backlog, synthèse) avec une évaluation, et demande une décision. | Lire, puis valider ou refuser explicitement. | Valider sans lire. |
| 🟡 **Une demande de permission** | Claude Code affiche une demande d'autorisation pour modifier un fichier ou lancer une commande. | Lire ce qui va être fait, puis accepter ou refuser. | Tout accepter machinalement. |
| 🔴 **Une remontée** | Pendant la réalisation, le Tech Leader vous signale un problème qu'il ne peut pas trancher seul. | Prendre la décision de fond. | Lui laisser décider à votre place. |

## 🟡 Les questions

- **Répondez question par question.** Le Tech Leader les numérote pour cela.
- **« Je ne sais pas » est une bonne réponse.** Il vous proposera des options avec leurs avantages et
  leurs inconvénients.
- **Sur le fond, ne dites pas « fais comme tu veux ».** Une règle de calcul ou le traitement d'un cas
  particulier sont **vos** décisions. Sur une question purement technique, vous pouvez en revanche
  lui demander sa recommandation.

## 🔴 Les portes de validation

À chaque porte, le Tech Leader joint au livrable une **évaluation honnête** : les risques et les
points fragiles, les hypothèses qu'il a prises, son niveau de confiance, ce qu'il ferait autrement,
et la **décision attendue** avec sa recommandation.

Ce que vous vérifiez dépend de la porte :

| Porte | Ce que vous vérifiez |
|---|---|
| Spécification | Qu'elle décrit **votre** besoin, et que chaque critère d'acceptation correspond à ce que vous attendez vraiment. C'est la **référence de tous les tests** : un oubli ici se paie à la fin. |
| Conception | Vous n'avez pas à juger la technique : vérifiez que les **conséquences** vous conviennent (installations, limites annoncées, coût de maintenance). |
| Backlog | L'ordre des tâches, et que chacune a une fin vérifiable. |
| Porte finale | Que le résultat fonctionne : **essayez-le vous-même**, avec la commande indiquée. |

- **Validez explicitement** : « Validé, tu peux passer à la conception. » Un accord ne vaut que pour
  cette porte.
- **Osez dire non**, ou « pas encore ». Revenir en arrière coûte peu à ce stade, beaucoup plus une
  fois le code écrit.
- **Écoutez les désaccords.** Quand le Tech Leader vous contredit, il doit argumenter et proposer une
  alternative. La décision reste la vôtre.

## 🟡 Les demandes de permission

Elles viennent de Claude Code lui-même, pas du Tech Leader. Leur fréquence dépend de votre
[mode de permission](../comprendre/notions.md#les-permissions) : en **Manual**, chaque modification
de fichier et chaque commande vous est soumise ; en **Auto**, presque rien.

Acceptez si l'action correspond à la tâche en cours. En cas de doute, refusez : le Tech Leader vous
expliquera ce qu'il voulait faire.

## 🔴 Les remontées

Pendant la réalisation, l'équipe peut tomber sur un point que personne n'avait prévu. Le Tech Leader
a pour consigne de **vous le remonter**, au lieu de trancher en silence. Quelques exemples :

- « La spécification ne dit pas ce qui doit se passer pour un montant vide. Que voulez-vous ? »
- « La documentation de l'outil retenu contredit l'hypothèse de la conception : il ne sait pas faire
  X. Je propose deux options. »
- « Le Developer n'a pas pu terminer la tâche 3 : il lui manque un accès à la base de test. »

Une remontée est une **décision de fond**. Votre réponse enrichit souvent la spécification.

## Quand intervenir de vous-même

En dehors de ces quatre cas, laissez l'équipe travailler. Intervenez seulement face à l'un de ces
signaux :

| Signal | Que faire |
|---|---|
| L'équipe part dans une direction que vous n'avez pas validée, ou ajoute ce qui n'était pas demandé. | **Stop**, puis recadrez. |
| Elle tourne en rond : même erreur, mêmes tentatives. | **Stop**, puis demandez-lui un point de situation. |
| Elle en fait trop pour le niveau du projet : questions de détail, documents interminables. | Rappelez-lui le niveau : « On est au niveau `poc`, note-le hors niveau. » |
| Elle annonce « tout fonctionne » sans preuve. | Demandez la sortie réelle de la commande. |
| L'indicateur de contexte approche du maximum. | Lancez `/avant-compactage` (voir [Piloter une session](session.md)). |
| La conversation s'est arrêtée faute de crédit. | Lancez `/reprendre-apres-coupure` (voir [Piloter une session](session.md)). |

## Ce que vous pouvez ignorer

Vous n'avez **pas** à suivre :

- les **fiches de tâche** et les **comptes rendus** échangés entre le Tech Leader et le Developer.
  C'est la mécanique interne de l'équipe : voir
  [En coulisses : la fiche de tâche](../comprendre/coulisses-fiche-de-tache.md) et
  [En coulisses : le compte rendu](../comprendre/coulisses-compte-rendu.md) ;
- les lectures de fichiers et les recherches web, qui défilent dans la conversation ;
- les vérifications faites par l'instance neuve du Developer : le Tech Leader vous en donne la
  conclusion.

??? abstract "Sources"
    - Comportement du Tech Leader : `C-Users-votre-nom-.claude/agents/tech-leader.md`
    - Modes de permission :
      [code.claude.com/docs/en/permission-modes](https://code.claude.com/docs/en/permission-modes)
