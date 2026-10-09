# Differences from David

This file records deliberate differences between this project and David's original XXIIVV site. It is a change log of design decisions, not a list of accidental mismatches.

Reference: [XXIIVV / Oscean source](https://github.com/XXIIVV/oscean)

## Navigation: keep the three-column layout stable

**David's behavior:** when the current page is a leaf at the end of a navigation branch, the generated menu can contain only the first and second lists; the third list is empty. The rendered layout can consequently shift left. Example: [Shavian](https://wiki.xxiivv.com/shavian.html) (compare with the [generated HTML](https://github.com/XXIIVV/oscean/blob/main/site/shavian.html)).

**Our deliberate difference:** preserve the navigation's three-column positions. Do not shift the useful first column left or collapse the layout just because the current page has no children. Keep the third column's place available; when there are no children to show, it may be empty. The column positions should not depend on whether the current page is a leaf.

This is a layout decision, not a claim that David's behavior is a bug. We are intentionally choosing stable column positions over reproducing that shift.

## Header and logo positioning

**David's layout:** the header uses a float-based layout; the navigation follows it in normal flow.

**Our deliberate difference:** use a CSS Grid layout for the page regions and place the header and navigation explicitly in the first grid row. This changes how the logo/header and navigation are positioned and prevents the layout shift we were correcting. The change is about placement and layout behavior, not simply making the logo larger. The logo asset itself has explicit dimensions of 200 × 42.

Relevant files: [default layout](https://github.com/devAItester/d00-jk-bc/blob/main/_layouts/default.html) and [styles](https://github.com/devAItester/d00-jk-bc/blob/main/_includes/style.css).

## Page background

**David's layout:** the CSS uses a repeating halftone background image.

**Our deliberate difference:** use a plain page background rather than the halftone texture. This keeps the copy minimal and avoids importing that decorative background asset.

## Footer layout

**David's layout:** the footer uses a fixed height and inline-block positioning for its children.

**Our deliberate difference:** place the footer in the page grid as its own row and use a simpler footer structure. Its sizing and positioning are therefore not an exact copy of David's CSS.

## Implementation approach

The project reproduces the file-oriented navigation idea with Jekyll, Markdown files, and Liquid templates. The source directory tree supplies the content hierarchy; the site is generated as static HTML. The project avoids JavaScript and external runtime dependencies.

This is an implementation difference rather than a pixel-level design difference.

## Items to verify before treating as intentional

Only differences explicitly described above are currently recorded as deliberate. Other visual or semantic mismatches—such as list spacing, individual page markup, icons, or responsive behavior—must be compared with the published reference before deciding whether to preserve or fix them.
