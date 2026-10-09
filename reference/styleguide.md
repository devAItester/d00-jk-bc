---
layout: default
title: styleguide
---

# Styleguide

Это отдельная спецификация визуального языка и HTML-структуры, восстановленная по живому референсу XXIIVV.

Референс принципиально минимален: семантический HTML, системная serif-типографика, чёрно-белая палитра, фиксированный вертикальный ритм и небольшое количество CSS-правил. Oscean прямо описывает результат как HTML, доступный screen-readers и terminal browsers, без JavaScript и с очень маленькой таблицей стилей.

## 1. Page skeleton

    <header>...</header>
    <nav>...</nav>
    <main>...</main>
    <footer>...</footer>

## 2. Global typography and page background

Основной шрифт — serif, размер — 16px. Основной цвет — #000, фон body — #fff. У html есть отдельный повторяющийся фон `media/icon/halftone.gif` с `background-attachment: fixed`; он виден там, где белый фон body не закрывает документ. В тёмной теме body становится чёрным, а правило фона html сохраняется. Глобальный reset обнуляет margin/padding и убирает стандартное text-decoration.

## 3. Vertical rhythm

Базовая единица вертикального ритма — 30px. Абзацы используют line-height 160%, пункты списков — 25px. Не следует заменять этот общий ритм большим количеством локальных интервалов.

## 4. Header

Референсный header:

    header { float:left; margin:50px 30px; margin-right:60px }

Это не sticky-header и не отдельная панель. Заголовок сайта является частью верхней композиции.

## 5. Navigation

Навигация — главное композиционное правило сайта.

    nav { padding:45px 30px; margin:0 }
    nav ul { padding:0; margin:0 45px 0 0; display:inline-block; vertical-align:top }
    nav ul li { list-style-type:none; white-space:pre }
    nav ul li a { padding:0 4px }

Колонки образуются соседними ul. Списки не вкладываются друг в друга для имитации колонок.

### Navigation groups

Меню показывает локальный участок дерева, а не полную карту сайта.

Для root: children(root).

Для глубины 1: children(root), затем children(current).

Для глубины 2 и более: children(grandparent), children(parent), children(current).

В исходной HTML-разметке могут присутствовать пустые списки: например, в текущем `site/styleguide.html` третья группа задана как `<ul></ul>`. В нашей Jekyll-версии сейчас выводятся только непустые списки; это известное отличие, которое следует оценивать вместе с согласованным требованием сохранять положение колонок. Максимум — три соседние вертикальные группы. Текущая страница подчёркивается классом self.

Навигация не является dropdown, sidebar-tree или accordion. Это несколько обычных вертикальных списков, расположенных горизонтально.

## 6. Main content

Основная текстовая мера — 624px:

    main { margin-left:30px; max-width:624px; clear:both; position:relative }

Обычные ссылки подчёркиваются. Внешние ссылки могут получать dotted underline.

## 7. Headings

Используется обычная HTML-иерархия h1–h5. Уровень выбирается семантически, а не по удобству визуального размера. Максимальная мера заголовков — 400px.

## 8. Paragraphs and quotes

Абзацы используют line-height 160%. q — serif, 18px, italic, max-width 400px. cite выводится отдельным блоком с автоматическим префиксом «— ».

## 9. Lists

Списки имеют margin 0 0 30px 30px. Пункты используют line-height 25px и горизонтальный padding 5px.

## 10. Images and figures

Обычные изображения ограничены шириной main. Первый figure страницы — специальный lead-элемент: width 800px, max-width 100vw, margin-left -30px. figcaption получает padding 15px 0.

## 11. Article

Article имеет пунктирную левую границу и padding-left 25px. Вложенный h2 может быть визуально скрыт без удаления семантического элемента.

## 12. Tables

Таблицы предназначены только для табличных отношений. td/th используют vertical-align top, padding 2.5px 5px и text-align left.

## 13. Code

Inline code сохраняет пробелы. pre получает overflow:auto, фон #efefef, padding 10px и font-size 80%. Внутренний code/i имеет цвет #888. tab-size — 2.

## 14. Keyboard input

kbd — небольшой типографический элемент с border 2px solid #222, line-height 20px, font-size 12px и padding 0 5px.

## 15. Footer

Footer отделяется пунктирной верхней границей и использует тот же 30px вертикальный ритм.

## 16. Interaction

Hover предельно простой: чёрный фон и белый текст. Нет анимаций, теней, dropdown-эффектов или JavaScript для базовой навигации.

## 17. Dark mode

Dark mode определяется prefers-color-scheme: dark. Фон становится #000, текст #fff, hover инвертируется, pre получает #111.

## 18. Low-tech constraints

Публичные страницы должны оставаться читаемыми без JavaScript, использовать обычные a href, сохранять текст в DOM и иметь подходящие text alternatives для изображений. Основная навигация не должна зависеть от внешнего запроса.

## 19. Source of truth and verification

- [Live style specimen](https://wiki.xxiivv.com/site/styleguide.html) — образцы HTML-элементов и их визуального оформления.
- [Current source CSS](https://github.com/XXIIVV/oscean/blob/main/links/main.css) — источник точных селекторов и свойств.
- [Oscean engine notes](https://wiki.xxiivv.com/site/oscean.html) — ограничения реализации: обычный HTML, отсутствие JavaScript в сгенерированных страницах, пригодность для screen readers и terminal browsers.
- [About](https://wiki.xxiivv.com/site/about.html) — философия архитектуры, не исчерпывающая спецификация CSS.

При копировании сравнивать не только визуальные элементы: сверять весь набор селекторов и деклараций, глобальные правила `html`/`body`, медиа-запросы, ресурсы и пути URL. После этого отдельно сравнивать DOM/HTML, а затем визуальный результат.

Живой эталонный пример: https://wiki.xxiivv.com/site/styleguide.html

Страница показывает headings, paragraph, inline markup, lists, table, pre block, quote, image, figure и footer.