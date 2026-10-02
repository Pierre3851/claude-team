"""Imprime en PDF la page print_page.html produite par le plugin mkdocs-print-site-plugin.

Le navigateur (piloté par Playwright) attend que tous les diagrammes Mermaid soient rendus avant
d'imprimer. Construire d'abord le site avec `mkdocs build`, SANS la variable DOCS_SITE_URL : sinon
Material charge Mermaid depuis le site en ligne.

Usage :
    python outils/construire_pdf.py --site site --navigateur msedge --sortie documentation.pdf

--navigateur : `msedge` ou `chrome` utilisent le navigateur du poste ; `chromium` celui de
Playwright (installé par `playwright install chromium`).
"""

import argparse
import sys
from pathlib import Path

from playwright.sync_api import sync_playwright

DELAI_RENDU_MS = 60_000


def main():
    analyseur = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    analyseur.add_argument("--site", required=True, type=Path, help="dossier du site construit")
    analyseur.add_argument("--navigateur", required=True, choices=["msedge", "chrome", "chromium"])
    analyseur.add_argument("--sortie", required=True, type=Path, help="PDF à produire")
    args = analyseur.parse_args()

    page_html = args.site / "print_page.html"
    if not page_html.is_file():
        raise FileNotFoundError(f"{page_html} introuvable : le site est-il construit avec print-site ?")
    diagrammes = page_html.read_text(encoding="utf-8").count('<pre class="mermaid">')

    with sync_playwright() as playwright:
        navigateur = playwright.chromium.launch(channel=None if args.navigateur == "chromium" else args.navigateur)
        page = navigateur.new_page()
        page.goto(page_html.resolve().as_uri(), wait_until="networkidle")
        page.wait_for_function(
            "n => document.querySelectorAll('pre.mermaid').length === 0"
            " && document.querySelectorAll('div.mermaid').length === n",
            arg=diagrammes,
            timeout=DELAI_RENDU_MS,
        )
        args.sortie.parent.mkdir(parents=True, exist_ok=True)
        page.pdf(path=str(args.sortie), format="A4", print_background=True, outline=True, tagged=True,
                 margin={"top": "15mm", "bottom": "15mm", "left": "12mm", "right": "12mm"})
        navigateur.close()

    print(f"PDF écrit : {args.sortie} ({diagrammes} diagramme(s) Mermaid rendu(s))")


if __name__ == "__main__":
    try:
        main()
    except Exception as erreur:
        print(f"ERREUR : {erreur}", file=sys.stderr)
        sys.exit(1)
