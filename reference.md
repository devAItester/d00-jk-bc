---
layout: default
title: reference
permalink: /reference.html
---

# Reference

Практическая спецификация тестового сайта: структура исходников, контент, навигация, HTML, media, типографика, интервалы и цвет.

## Разделы

- [structure](structure.html) — что является страницей, разделом, README и ресурсом.
- [content](content.html) — как добавить, переместить или удалить страницу и раздел.
- [styleguide](styleguide.html) — функциональные HTML/CSS-примеры.
- [navigation](navigation.html) — точная модель локальной многоуровневой навигации.
- [media](media.html) — организация, форматы, размеры, alt, captions, metadata и индексирование изображений.
- [html](html.html) — требования к HTML-разметке, доступности и поисковой индексации.
- [spacing](spacing.html) — интервалы, текстовая мера и принципы типографической композиции.
- [color](color.html) — монохромная модель, dark mode и роль акцентного цвета.

## Основной принцип

Сайт должен оставаться простым для редактирования в исходниках:

    дерево каталогов
        ↓
    Markdown и ресурсы
        ↓
    Jekyll
        ↓
    статический HTML/CSS

Навигация является представлением дерева, а не отдельным источником истины.

## Разработка

Отдельная воспроизводимая реализация навигации и других внутренних механизмов находится в разделе [Development](../development/).

## Нормативные источники

- [WHATWG HTML Living Standard](https://html.spec.whatwg.org/)
- [W3C WCAG 2.2 Techniques](https://www.w3.org/WAI/WCAG22/Techniques/)
- [Google Search Central — SEO for developers](https://developers.google.com/search/docs/fundamentals/get-started-developers)
- [Google Search Central — image SEO](https://developers.google.com/search/docs/appearance/google-images)
- [Google Search Central — crawlable links](https://developers.google.com/search/docs/crawling-indexing/links-crawlable)
- [Google Search Central — sitemaps](https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap)
- [Jekyll — Pages](https://jekyllrb.com/docs/pages/)
- [Jekyll — Liquid filters](https://jekyllrb.com/docs/liquid/filters/)
