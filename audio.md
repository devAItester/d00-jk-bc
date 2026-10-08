---
layout: default
title: audio
permalink: /audio.html
---
<h1>audio</h1>
<ul>
{% for p in site.pages %}
  {% assign pparts = p.path | split: '/' %}
  {% if pparts[0] == 'audio' and p.path != 'audio/index.md' %}
    {% assign link = p.path | replace: '.md', '.html' | prepend: '/' %}
    <li><a href="{{ link | relative_url }}">{{ p.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>