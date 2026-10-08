---
layout: default
title: media
---

# Media

`media/` — отдельный ресурсный слой. Он хранит изображения, видео, SVG и другие бинарные объекты, которые используются содержательными страницами.

Media не должна превращаться в отдельный параллельный каталог статей.

## Directory model

Рекомендуемая организация:

    media/
        diary/
        generic/
        icon/
        identity/
        refs/
        services/

Названия каталогов описывают функцию ресурса, а не место, где он случайно используется сегодня.

## Filename

Имя файла должно быть стабильным и описательным:

    macbook-air-2014-keyboard.jpg
    terminal-layout-dark.png
    navigation-tree.svg

Не следует использовать:

    IMG_0042.JPG
    screenshot-final-final2.png
    image1.png

Для поискового обнаружения Google рекомендует описательные filenames и релевантный surrounding text. urlGoogle — image SEOhttps://developers.google.com/search/docs/appearance/google-images

## Formats

Практическое правило:

| Format | Основное назначение |
| --- | --- |
| JPEG | фотографии |
| PNG | изображения с lossless quality или прозрачностью |
| SVG | векторная графика и иконки |
| GIF | только когда нужна именно GIF-анимация |
| MP4 | видео |
| WebP/AVIF | современные responsive image variants, если pipeline их поддерживает |

Выбор формата определяется содержимым, качеством и стоимостью загрузки, а не только привычкой.

## Dimensions

У каждого изображения должны быть известны intrinsic dimensions.

В HTML:

    <img
      src="/media/example.jpg"
      width="1200"
      height="800"
      alt="...">

Для responsive variants сохраняется исходное aspect ratio.

Текстовая мера референса — около 624px. Обычные изображения вписываются в неё.

Lead figure может быть шире:

    width: 800px;
    max-width: 100vw;

Это визуальное правило референса, а не требование поисковой системы.

## 3/4-width versus full-width

Основная композиция строится вокруг текстовой колонки, поэтому большая часть изображений визуально находится примерно в той же области, что и текст.

Широкое первое изображение используется как композиционный акцент. Оно не обязано иметь специальный SEO-статус.

SEO определяется прежде всего crawlability, релевантностью, `alt`, surrounding text и качеством самого ресурса. citeturn3search0

## Responsive images

Для нескольких физических размеров:

    <img
      src="/media/photo-800.jpg"
      srcset="/media/photo-400.jpg 400w,
              /media/photo-800.jpg 800w,
              /media/photo-1200.jpg 1200w"
      sizes="(max-width: 624px) 100vw, 624px"
      width="1200"
      height="800"
      alt="...">

`srcset` описывает доступные ресурсы, `sizes` — предполагаемую отображаемую ширину.

Для lead image `sizes` должен соответствовать фактической responsive geometry, а не всегда текстовой мере 624px.

## Loading

Для изображений ниже первого экрана допустим native lazy loading:

    loading="lazy"

Критическое первое изображение не следует без причины лениво загружать.

`width` и `height` остаются обязательной практикой независимо от loading strategy.

## Alt

### Informative

    alt="Схема каталогов и страниц сайта"

`alt` должен передавать информацию, ради которой изображение присутствует.

### Decorative

    alt=""

Пустой `alt` означает, что изображение не добавляет содержательного сообщения.

### Functional

Если изображение является ссылкой:

    <a href="/gallery/">
      <img src="/media/gallery.png" alt="Gallery">
    </a>

Здесь `alt` сообщает назначение ссылки.

WCAG прямо разделяет informative, decorative и functional images и требует соответствующей text alternative. 

## Figure and caption

Когда изображение имеет самостоятельную связь с подписью:

    <figure>
      <img src="/media/example.jpg"
           width="1200"
           height="800"
           alt="...">
      <figcaption>Источник: ...</figcaption>
    </figure>

Caption не должен дублировать `alt` без необходимости.

## Credits and licensing

Для внешних или лицензированных материалов следует сохранять как минимум:

- creator;
- credit;
- copyright notice;
- license;
- источник получения;
- исходный URL, если он нужен для проверки;
- дату получения, если provenance имеет значение.

Для image metadata Google поддерживает creator, creditText, copyrightNotice и license в соответствующем structured data/ImageObject контексте. urlGoogle — image metadata structured datahttps://developers.google.com/search/docs/appearance/structured-data/image-license-metadata

Метаданные файла и HTML metadata не являются взаимозаменяемыми. Если provenance критичен, его лучше сохранять и в исходном media asset, и в контексте страницы.

## SVG

SVG подходит для векторных схем, иконок и другой графики.

Если SVG содержит самостоятельный смысл, accessibility должна обеспечиваться содержательной текстовой альтернативой или доступным текстом рядом.

SVG, полученный из внешнего источника, следует рассматривать как потенциально исполняемый XML-ресурс и не принимать вслепую из непроверенного источника.

## Search discovery

Чтобы изображение могло быть найдено поисковой системой:

- URL изображения должен быть crawlable;
- файл не должен блокироваться robots/noindex-механизмами;
- изображение должно быть реально доступно на странице или через другой crawlable context;
- filename должен быть описательным;
- `alt` должен соответствовать смыслу;
- surrounding text должен быть релевантным;
- при необходимости URL изображения можно включить в sitemap.

Google отдельно рекомендует проверять crawlability изображений и использовать sitemap для облегчения discovery. urlGoogle — image SEOhttps://developers.google.com/search/docs/appearance/google-images

## Resource budget

Размер файла — не нормативная величина, а performance budget.

Практический подход:

- сначала выбрать правильный формат;
- затем уменьшить pixel dimensions до реального display size;
- затем оптимизировать compression;
- затем добавить responsive variants;
- затем проверить фактическую загрузку в браузере.

Нельзя задавать универсальное правило «каждая картинка должна быть не больше N KB»: фотография, SVG и короткое видео имеют принципиально разные профили данных.

## Rule of thumb

    source asset
        ↓
    intrinsic dimensions
        ↓
    optimized derivatives
        ↓
    semantic HTML
        ↓
    alt + caption + credit
        ↓
    crawlable URL
