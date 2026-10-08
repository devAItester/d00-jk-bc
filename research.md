---
layout: default
title: research
permalink: /research.html
---
<h1>research</h1>
<ul>
{% for p in site.pages %}
  {% assign pparts = p.path | split: '/' %}
  {% if pparts[0] == 'research' and p.path != 'research/index.md' %}
    {% assign link = p.path | replace: '.md', '.html' | prepend: '/' %}
    <li><a href="{{ link | relative_url }}">{{ p.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>