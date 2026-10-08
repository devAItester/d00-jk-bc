---
layout: default
title: software
permalink: /software.html
---
<h1>software</h1>
<ul>
{% for p in site.pages %}
  {% assign pparts = p.path | split: '/' %}
  {% if pparts[0] == 'software' and p.path != 'software/index.md' %}
    {% assign link = p.path | replace: '.md', '.html' | prepend: '/' %}
    <li><a href="{{ link | relative_url }}">{{ p.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>