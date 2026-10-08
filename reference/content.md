---
layout: default
title: content
---

# Content

Контент добавляется и удаляется изменением файлового дерева. Отдельный глобальный реестр страниц не требуется.

## Add a page

Создай Markdown-файл внутри нужного каталога:

    software/
        tools/
            terminal.md

Минимальное содержимое:

    ---
    layout: default
    title: terminal
    ---

    # Terminal

    Содержимое страницы.

После сборки текущий permalink `/:path/:basename.html` создаст URL:

    /software/tools/terminal.html

Если нужен другой публичный URL, его следует задавать явно через front matter `permalink`.

## Add a section

Для нового раздела создай каталог и его landing page:

    research/
        systems/
            index.md
            notes.md

`index.md` делает `systems` публичным node и даёт ему собственный URL:

    /research/systems/

Остальные Markdown-файлы становятся дочерними страницами.

## Add a post to an existing section

Добавь новый файл рядом с существующими страницами:

    software/
        tools/
            index.md
            terminal.md
            shell.md
            tmux.md

Навигация строится автоматически по пути.

## Move a page

Перемещение файла меняет его URL, если front matter не сохраняет прежний permalink.

Например:

    research/old.md
    ->
    research/systems/old.md

изменяет URL с:

    /research/old.html

на:

    /research/systems/old.html

Для уже опубликованной страницы изменение URL следует считать миграцией, а не простой операцией filesystem.

## Remove a page

Удаление Markdown-файла удаляет соответствующую страницу из следующей сборки.

Если старый URL уже был опубликован или проиндексирован, необходимо отдельно решить вопрос с redirect или иным сохранением URL. Удаление файла само по себе не является HTTP redirect.

## Remove a section

Удаление `index.md` убирает сам каталог из navigation tree как публичный section node. Удаление дочерних страниц убирает соответствующие nodes.

Пустой каталог не должен создавать navigation node.

## Internal links

Используй обычные HTML/Markdown links с реальным `href`:

    [terminal](../tools/terminal.html)

или:

    <a href="../tools/terminal.html">terminal</a>

Для поисковых систем и accessibility важнее реальный destination URL и осмысленный anchor text, чем визуальный способ оформления ссылки.

## Title contract

Пустой `title` недопустим.

Причина не только в navigation. `title` участвует в формировании HTML `<title>`, подписи узла меню и других представлений страницы.

В репозитории есть отдельная CI-проверка `scripts/check-pages.sh`, которая завершает сборку с ошибкой, если Markdown-страница не содержит непустой `title` в front matter.

Это принципиальное отличие от простой проверки в Liquid:

    {% if p.title %}
      ...
    {% endif %}

Liquid-защита предотвращает пустой HTML, но молча скрывает дефект исходника. CI должна делать дефект явным.

## Publication dates

Дата исходной публикации — это свойство контента, а не дата последнего изменения файла.

Если контент переносится из внешней системы, исходную дату следует хранить явно:

    ---
    layout: default
    title: terminal
    datePublished: 2024-05-18
    ---

Дата публикации и дата изменения не должны подменять друг друга. Для статей, где дата имеет смысл для поиска, её можно дополнительно выводить в HTML и передавать в соответствующие structured data.

Google допускает `datePublished` и `dateModified` в Article structured data. urlGoogle — Article structured datahttps://developers.google.com/search/docs/appearance/structured-data/article

## Principle

Файл создаёт страницу.

Каталог создаёт контекст.

`index.md` создаёт публичный узел каталога.

Navigation читает это дерево, а не поддерживает собственную копию структуры.
