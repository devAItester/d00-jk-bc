# flatfiletxtdb

Minimal flat-file text database experiment based on the navigation and file-oriented publishing model of XXIIVV.

The source of the site is the directory tree itself. Markdown files are nodes; directories provide the navigation hierarchy. Jekyll only turns that tree into static HTML.

Properties:

- Jekyll + Markdown
- no JavaScript
- no external dependencies
- Normal Flow layout
- deep directory navigation
- breadcrumbs
- local SVG media
- Liquid-generated navigation and incoming links
- content stored as ordinary text files

Run locally:

    bundle exec jekyll serve

Then open the local server shown by Jekyll.
