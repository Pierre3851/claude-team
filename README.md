# claude-team — une équipe d'agents pour Claude Code

> **English summary.** A ready-to-use configuration kit for [Claude Code](https://code.claude.com/docs)
> (VS Code extension) that turns a single assistant into a two-role team: a **Tech Leader** that
> clarifies your need, decides with you at explicit validation gates and verifies the work, and a
> **Developer** that executes precisely scoped tasks. It ships shared working rules, engineering
> rules with adjustable quality levels (from proof-of-concept to client release), and session
> commands. Documentation is in French.

Un kit de configuration pour **Claude Code**, utilisé dans **VS Code** via son extension. Au lieu d'un
assistant unique qui fait tout, vous travaillez avec une petite équipe :

- un **Tech Leader** qui clarifie votre besoin, décide avec vous à des **portes de validation**, puis
  délègue et vérifie ;
- un **Developer** qui exécute des tâches précises et rend compte honnêtement.

Le kit s'adresse à des personnes proches de la technique, sans être développeurs de métier.

## 📖 Documentation

- **En ligne** : <https://pierre3851.github.io/claude-team/>
- **En PDF** : joint à chaque [Release](https://github.com/Pierre3851/claude-team/releases)

Commencez par la section **Démarrer** : installer Claude Code, installer le kit, initialiser un
projet.

## Contenu du dépôt

| Élément | Rôle |
|---|---|
| `C-Users-votre-nom-.claude/` | Configuration personnelle, à copier dans `C:\Users\<votre-nom>\.claude\` : socle commun, rôles, réglages, commandes |
| `mon-projet-claude-code/` | Modèle à recopier pour chaque nouveau projet : document projet, règles d'ingénierie, activation du Tech Leader |
| `docs/`, `includes/`, `mkdocs.yml` | Sources de la documentation |
| `outils/construire_pdf.py` | Impression en PDF de la page imprimable du site (`print_page.html`) |
| `.github/workflows/` | Publication sur GitHub Pages et PDF des Releases |

## ⚠️ À savoir avant de l'utiliser

- **Projet communautaire, non affilié à Anthropic** ni approuvé par Anthropic. « Claude » et
  « Claude Code » sont des marques d'Anthropic.
- **Les agents agissent sur votre machine** : ils lisent et modifient des fichiers et lancent des
  commandes. Lisez ce que vous autorisez ; vous restez responsable de ce qui est exécuté.
- **Coût** : le kit règle les sessions sur le modèle **Opus**, le plus capable et le plus coûteux, et
  fait travailler plusieurs agents. Un abonnement Claude **payant** (Pro, Max, Team, Enterprise) ou un
  compte Console est nécessaire.
- **Validité** : Claude Code évolue vite. Le kit et sa documentation ont été vérifiés en
  **octobre 2026** avec la documentation officielle de Claude Code de cette date.
- **Windows** : la documentation est écrite pour Windows.
- Fourni **tel quel**, sans garantie (voir la licence).

## Licence

[MIT](LICENSE).

## Construire la documentation

Pour contribuer à la documentation. Depuis la racine du dépôt, dans PowerShell, avec Python 3.13 :

```powershell
py -3.13 -m venv .venv
.venv\Scripts\python.exe -m pip install -r requirements-docs.txt

# Vérification stricte des liens et des ancres (échoue au moindre avertissement)
$env:DOCS_PRIVACY = "false"; .venv\Scripts\python.exe -m mkdocs build --strict
Remove-Item Env:DOCS_PRIVACY

# Construction du site, puis aperçu qui se recharge à chaque modification
.venv\Scripts\python.exe -m mkdocs build --clean
.venv\Scripts\python.exe -m mkdocs serve

# PDF (avec le navigateur Edge installé sur le poste)
.venv\Scripts\python.exe outils\construire_pdf.py --site site --navigateur msedge --sortie documentation.pdf
```

- **Avertissements `Couldn't create symbolic link`** : sous Windows, la construction du site les
  affiche. Ils viennent du plugin `privacy`, faute de droits de lien symbolique. Les fichiers utilisés
  par le site sont néanmoins copiés.
- **Ne définissez pas `DOCS_SITE_URL` en local** : sinon Material charge Mermaid depuis le site en
  ligne, et les diagrammes disparaissent du PDF.
- **Material for MkDocs est en maintenance**, avec des correctifs de sécurité jusqu'à
  novembre 2026 au moins. Son successeur, [Zensical](https://zensical.org), lit directement
  `mkdocs.yml`.
