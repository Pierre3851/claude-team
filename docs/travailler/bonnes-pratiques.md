# Bien formuler et réagir

Le système est conçu pour vous poser des questions et vous laisser décider. Il donne le meilleur de
lui-même si vous jouez votre rôle, celui du **commanditaire** : vous savez **ce que vous voulez** et
**pourquoi**, et c'est vous qui validez.

## Formuler un besoin

**Décrivez le problème et le résultat voulu, pas la solution.**

| ✅ Plutôt | ❌ Plutôt pas |
|---|---|
| « Chaque lundi, je recopie à la main les ventes du fichier Excel de la veille dans un rapport. Je voudrais que ce soit automatique. » | « Écris-moi un script pandas qui lit un xlsx. » |

Le Tech Leader vous aidera à trouver le *comment*. Donnez-lui plutôt :

- **le contexte** : qui utilise le résultat, à quelle fréquence, sur quelle machine ;
- **un exemple réel de la forme** des données, **fabriqué ou anonymisé** : jamais de données
  personnelles ni de secrets ;
- **les contraintes** : délai, outils imposés ou interdits ;
- **les documents existants** : cahier des charges, description d'un format. Déposez-les dans le
  projet et référencez-les dans la rubrique « Documentation de référence » du document projet.

Pour répondre aux questions et passer les portes de validation, voir
[Vos moments d'attention](attention.md).

## Ce qu'il ne faut pas faire

!!! danger "Court-circuiter le Tech Leader"
    Lui demander « écris le code toi-même, ça ira plus vite » va contre son rôle : il n'écrit jamais
    de code. Pour une petite question ponctuelle, ouvrez plutôt dans VS Code un dossier qui n'a pas
    le réglage `agent` : vous y aurez un Claude Code **ordinaire**.

!!! warning "Donner une consigne durable uniquement dans le chat"
    Une consigne dite seulement dans la conversation peut se perdre quand le contexte se compacte.
    Si elle doit valoir pour tout le projet, demandez au Tech Leader de l'**ajouter au document
    projet**, ou ajoutez-la vous-même.

!!! warning "Coller un secret dans la conversation"
    Une clé d'API ou un mot de passe se range dans `.env`, jamais dans le chat.

## Garder un regard critique

Le système réduit fortement les erreurs, sans les supprimer. **Vous restez responsable** de ce qui
est produit :

- **essayez vous-même** le résultat, avec la commande indiquée dans la synthèse ;
- **méfiez-vous d'un « tout fonctionne » sans preuve**, et demandez la sortie réelle ;
- **faites évoluer le document projet** : chaque fois que vous corrigez deux fois la même chose,
  c'est une règle qui manque.
