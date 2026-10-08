---
layout: default
title: visual
permalink: /visual.html
---
<h1>visual</h1>
<ul>
{% for p in site.pages %}
  {% assign pparts = p.path | split: '/' %}
  {% if pparts[0] == 'visual' and p.path != 'visual/index.md' %}
    {% assign link = p.path | replace: '.md', '.html' | prepend: '/' %}
    <li><a href="{{ link | relative_url }}">{{ p.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>