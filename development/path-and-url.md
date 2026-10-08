---
layout: default
title: path and url
---

# Path and URL

## Правило

У страницы есть как минимум два разных адреса:

    source path
        ↓
    page.path
        ↓
    page.url
        ↓
    опубликованный HTML

Цепочка меню строится по дереву исходных страниц. Ссылка меню ведёт на page.url.

Поэтому путь в меню и URL обязаны быть согласованы семантически, но не обязаны совпадать посимвольно.

Jekyll прямо разделяет исходное расположение страницы и её output URL. В документации это сформулировано так: “Permalinks are the output path for your pages” — permalink задаёт путь результата, а не исходный путь файла. citeturn6search0

## Нормальный случай

Исходник:

    software/
      tools/
        notes.md

При глобальном:

    permalink: /:path/:basename.html

получаем:

    source: software/tools/notes.md
    page.path: software/tools/notes.md
    URL: /software/tools/notes.html

Меню:

    software
      tools
        tools notes

Адрес повторяет ту же смысловую цепочку:

    /software/tools/notes.html

Это предпочтительный случай для обычной страницы.

## Индекс раздела

Индекс — особый случай.

Исходник:

    software/
      tools/
        index.md

Если индекс получает permalink:

    /software/tools/

то пункт меню остаётся частью дерева:

    software
      tools index

но URL представляет сам раздел:

    /software/tools/

То есть label страницы и URL не обязаны быть одинаковыми. Это не ошибка навигации.

В текущем проекте выбран более строгий вариант: публичные страницы используют .html и для индексных страниц разделов. Поэтому:

    software/tools/index.md
        ↓
    /software/tools/index.html

Исключение — только корневая страница сайта:

    index.html
        ↓
    /

Это позволяет проверять адрес страницы непосредственно по generated HTML и не смешивать два режима URL.

## Явный permalink

Ещё сильнее расхождение возникает, когда файл:

    it/linux/cli/yazi.md

имеет:

    permalink: /tools/yazi.html

Меню всё равно вычисляет узел из:

    it → linux → cli → yazi

а ссылка ведёт на:

    /tools/yazi.html

Такой перенос допустим, но его нужно считать исключением: источник определяет место узла в дереве, permalink определяет публичный адрес.

## Как проектировать длинную IT-цепочку

Для практической базы удобно держать смысловую и URL-цепочку одинаковыми:

    it
      linux
        cli
          file-managers
            yazi
              configuration

Исходный файл:

    it/linux/cli/file-managers/yazi/configuration.md

Ожидаемый URL:

    /it/linux/cli/file-managers/yazi/configuration.html

Здесь каждый сегмент адреса объясняет, почему страница находится именно в этом месте меню.

Для нового материала сначала выбирается место в дереве, затем проверяется, что generated URL получается из того же пути. Не следует сначала придумывать красивый URL, а потом пытаться подогнать под него меню.

## Что проверять

Для каждой новой страницы:

    1. source path соответствует смысловой категории;
    2. title непустой;
    3. page.url ожидаемый;
    4. ссылка в меню использует page.url;
    5. generated HTML существует именно по этому URL;
    6. production отвечает по тому же адресу.

Минимальный пример:

    source:
      software/tools/notes.md

    expected:
      /software/tools/notes.html

    check:
      curl -I https://devaitester.github.io/flatfiletxtdb/software/tools/notes.html

## Что считать ошибкой

Ошибка — не любое различие source path и URL.

Ошибки:

    - menu link указывает не на page.url;
    - URL ведёт на несуществующий generated HTML;
    - permalink случайно ломает ожидаемую иерархию;
    - одна и та же страница получает несколько конкурирующих canonical addresses;
    - индекс раздела ошибочно исключён из дерева только потому, что его filename = index.md.

Не ошибка:

    source: software/tools/index.md
    URL: /software/tools/

если такой directory URL выбран сознательно и проверен.

## Практический принцип

Сначала проектируй дерево:

    где находится материал?

Затем проверяй маршрут:

    какой page.url получил этот узел?

И только после этого проверяй production:

    существует ли именно этот .html или directory URL?

Для этого сайта source tree — источник структуры, page.url — источник ссылки. Меню не должно пытаться самостоятельно реконструировать permalink.
