---
layout: default
title: sitemap
---

# Sitemap

This is the complete public page tree.

The tree is generated from `site.pages`.

- [home](../) — site root. Its hierarchy is derived from source paths, while each link uses the page's generated `url`. This makes the sitemap useful for checking both the content tree and the resulting addresses.

{% assign pages = site.pages | sort: "path" %}
{% include sitemap-tree.html parent="" pages=pages %}
