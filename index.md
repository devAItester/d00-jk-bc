---
layout: default
title: index
---
<h1>flatfiletxtdb</h1>
<p>A directory is a path. A Markdown file is a node.</p>
<ul>
{% for p in site.pages %}
  {% if p.path != 'index.md' and p.path != '404.html' and p.title and p.title != '' %}
    <li><a href="{{ p.url | relative_url }}">{{ p.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>
