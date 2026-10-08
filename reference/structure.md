---
layout: default
title: structure
---

# Structure

Сайт разделяет содержательный слой, структуру навигации, представление и бинарные ресурсы.

## Repository tree

    index.html
    _config.yml
    _layouts/
        default.html
    _includes/
        nav.html
        style.css

    audio/
        index.md
        aliceffekt/
            index.md
            notes.md

    reference/
        index.md
        structure.md
        content.md
        styleguide.md
        navigation.md
        media.md
        html.md
        spacing.md
        color.md

    development/
        index.md
        navigation.md

    media/
        README.md

## Roles

### Markdown page

Markdown-файл с Jekyll front matter является публичным контентом сайта и при сборке превращается в HTML-документ.

Минимальный контракт страницы:

    ---
    layout: default
    title: page title
    ---

Поле `title` обязательно. Оно используется как название страницы в `<title>`, навигации и других производных представлениях.

### Directory

Каталог является структурным namespace. Он группирует страницы и определяет их контекст в дереве навигации.

Сам по себе пустой каталог публичным разделом не является.

### index.md

`index.md` — публичная landing page каталога. Она даёт разделу стабильный URL и одновременно является node дерева.

Например:

    research/
        index.md
        systems/
            index.md

создаёт два публичных узла: `research` и `research/systems`.

### README.md

`README.md` — документация репозитория для сопровождающего, а не контент сайта. Он объясняет устройство исходников и намеренно исключён из Jekyll page collection.

`README.md` нельзя использовать вместо публичного `index.md`.

### media/

`media/` — namespace ресурсов, а не раздел содержимого. Здесь находятся бинарные и иные статические ресурсы, используемые страницами.

README внутри `media/` описывает ресурсное дерево для сопровождающего. Публичная документация о media находится в `reference/media.md`.

## Rule of thumb

    public content      -> *.md
    section landing     -> index.md
    repository notes    -> README.md
    binary/static data  -> media/
    layout              -> _layouts/
    reusable fragments  -> _includes/
    presentation        -> _includes/style.css

Такое разделение не позволяет служебной документации репозитория случайно стать публичным контентом и не позволяет ресурсам быть ошибочно принятыми за страницы.

## Source of truth

Иерархия каталогов и файлов является источником истины.

Меню не дублирует дерево отдельным YAML/JSON-реестром. Исключение — локальный служебный metafile `_menu`, который существует только там, где нужен пользовательский порядок.

Правило порядка:

    нет _menu
        ↓
    алфавитный порядок

    есть _menu
        ↓
    перечисленные страницы
        ↓
    остальные страницы в алфавитном порядке

`_menu` не имеет расширения и сам не является публичной страницей.

Для навигации Jekyll получает публичные pages, нормализует их пути в узлы дерева и строит локальные группы:

    children(grandparent)
    children(parent)
    children(current)

Глубина исходного дерева не кодируется в шаблоне меню.
