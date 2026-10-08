---
layout: default
title: html
---

# HTML

HTML-разметка должна одновременно удовлетворять семантической модели документа, требованиям accessibility и условиям нормального crawling/indexing.

Нормативная основа — WHATWG HTML Living Standard и WCAG 2.2. Для поискового представления дополнительно используются рекомендации Google Search Central.

## Document structure

Базовый каркас:

    <!doctype html>
    <html lang="ru">
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>...</title>
        <meta name="description" content="...">
      </head>
      <body>
        <header>...</header>
        <nav>...</nav>
        <main>...</main>
        <footer>...</footer>
      </body>
    </html>

`lang` должен соответствовать языку страницы. Для русскоязычного содержимого — `lang="ru"`.

## Title

У документа должен быть один содержательный `title`:

    <title>terminal — flatfiletxtdb</title>

Он должен идентифицировать документ вне контекста страницы.

## Headings

Основной заголовок — `h1`. Последующие уровни отражают логическую структуру:

    <h1>Page</h1>
    <h2>Section</h2>
    <h3>Subsection</h3>

Нельзя использовать heading только ради получения нужного размера текста. Уровень заголовка сообщает структуру документа и вспомогательным технологиям.

## Paragraphs

Обычный текст оформляется через `p`:

    <p>Текст абзаца.</p>

Не следует создавать абзацы через последовательность `br`, CSS-отступы или пустые элементы.

## Links

Основная форма ссылки:

    <a href="/research/">research</a>

Google рекомендует реальные `a href` links с описательным anchor text для crawlable navigation. urlGoogle — crawlable linkshttps://developers.google.com/search/docs/crawling-indexing/links-crawlable

## Images

Информативное изображение:

    <img src="/media/example.jpg"
         width="1200"
         height="800"
         alt="Краткое описание информации на изображении">

`alt` передаёт смысл изображения, а не обязан буквально перечислять каждый визуальный объект.

Для декоративного изображения:

    <img src="/media/ornament.svg" alt="">

Для изображения, являющегося единственным содержимым ссылки, `alt` должен описывать функцию destination:

    <a href="/gallery/">
      <img src="/media/gallery.png" alt="Gallery">
    </a>

Intrinsic `width` и `height` следует указывать, когда они известны: это позволяет браузеру заранее зарезервировать геометрию и уменьшить layout shift.

Для responsive images можно использовать:

    <img
      src="/media/photo-800.jpg"
      srcset="/media/photo-400.jpg 400w,
              /media/photo-800.jpg 800w,
              /media/photo-1200.jpg 1200w"
      sizes="(max-width: 624px) 100vw, 624px"
      width="1200"
      height="800"
      alt="...">

## Figure

`figure` используется для самостоятельного иллюстративного объекта:

    <figure>
      <img src="/media/example.jpg"
           width="1200"
           height="800"
           alt="...">
      <figcaption>Описание или credit.</figcaption>
    </figure>

## Code

Inline code:

    <code>git status</code>

Block code:

    <pre><code>git status
    git log --oneline</code></pre>

WHATWG определяет `pre` как блок предварительно форматированного текста; для программного кода семантической парой является `pre` + `code`. citeturn3search12

В данном стиле code-блок визуально отделён от основного текста CSS, а не дополнительной HTML-структурой.

## Video

Для нативного видео используется `video`:

    <video controls width="1280" height="720">
      <source src="/media/example.mp4" type="video/mp4">
    </video>

Размеры должны соответствовать intrinsic ratio.

## Iframe

Если внешний документ действительно является частью содержания:

    <iframe
      src="https://example.org/"
      title="Example"
      width="640"
      height="360">
    </iframe>

`title` необходим для accessibility. Внешнее встраивание не следует использовать для обычной текстовой информации, которую можно дать непосредственно в HTML.

## Accessibility

Критические правила:

- один логический `h1`;
- последовательная heading hierarchy;
- осмысленные link names;
- корректный `alt`;
- `alt=""` для чисто декоративных изображений;
- клавиатурно доступные интерактивные элементы;
- цвет не является единственным носителем смысла;
- видимый focus state должен сохраняться;
- содержательный текст должен присутствовать в DOM.

## Search indexing

Индексация не требует специальной «SEO-разметки» вместо нормального HTML.

Базовый приоритет:

1. доступный и уникальный основной контент;
2. содержательный `title`;
3. понятная heading hierarchy;
4. crawlable internal links;
5. crawlable images с корректными `alt`;
6. стабильные canonical URLs;
7. sitemap для URL, которые действительно нужно обнаружить и индексировать.

Google отдельно подчёркивает важность people-first content и доступности основного содержимого, а structured data должна соответствовать видимому содержанию. citeturn3search10turn3search7

## Structured data

Structured data добавляется только там, где она точно описывает страницу.

Для статьи возможны `Article`/соответствующий подтип, `headline`, `image`, `datePublished`, `dateModified` и `author`. Это дополнительный сигнал понимания контента, а не замена семантическому HTML. citeturn3search2

## Standards

- WHATWG HTML Living Standard — нормативная модель HTML.
- W3C WCAG 2.2 Techniques — практические accessibility techniques.
- Google Search Central — crawling, indexing, links, images и structured data.
