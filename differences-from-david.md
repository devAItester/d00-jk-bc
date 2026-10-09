# Differences from David

This file records only differences that we have deliberately chosen to keep in our recreation of David's XXIIVV site. A technical workaround or an observed mismatch is not automatically an intentional design decision.

Reference: [XXIIVV / Oscean source](https://github.com/XXIIVV/oscean)

## Navigation: keep the three-column layout stable

**David's behavior:** when the current page is a leaf at the end of a navigation branch, the generated menu can contain only the first and second lists; the third list is empty. The rendered layout can consequently shift left. Example: [Shavian](https://wiki.xxiivv.com/shavian.html) (compare with the [generated HTML](https://github.com/XXIIVV/oscean/blob/main/site/shavian.html)).

**Our deliberate difference:** preserve the navigation's three-column positions. Do not shift the useful first column left or collapse the layout just because the current page has no children. Keep the third column's place available; when there are no children to show, it may be empty. The column positions should not depend on whether the current page is a leaf.

This is a deliberate layout choice, not a claim that David's behavior is a bug.

## Header and logo: eliminate layout shift with minimal changes

The CSS Grid currently used in this project was introduced as a way to prevent the menu from shifting left when the logo had not loaded. It should be treated as a workaround to investigate, not as a deliberate visual difference from David.

**Preferred direction:** retain David's original float-based header and normal-flow navigation if the shift can be prevented by reserving the logo's space before the image loads. Give the logo link/container and image stable dimensions, then test slow loading and a failed SVG request. The current logo asset has explicit dimensions of 200 × 42, and the layout also supplies image dimensions; verify whether the link/container and loading behavior need additional constraints.

Do not record CSS Grid as a desired difference unless testing shows that the original layout cannot reliably avoid the shift.

Relevant files: [default layout](https://github.com/devAItester/d00-jk-bc/blob/main/_layouts/default.html) and [styles](https://github.com/devAItester/d00-jk-bc/blob/main/_includes/style.css).

## Other CSS differences: not yet confirmed as intentional

The current CSS also differs from David's in background treatment and footer layout. These are observed implementation differences, not confirmed design decisions. Do not treat them as intentional until we compare the published reference and explicitly decide to keep them.

## Implementation approach

The project uses Jekyll, Markdown files, and Liquid templates to reproduce the file-oriented navigation model. The directory tree supplies the content hierarchy, and Jekyll generates static HTML. This is an implementation choice; it does not by itself justify visual differences from David's site.

## Verification rule

Only differences explicitly described as deliberate above are accepted design deviations. Other mismatches—such as list spacing, page markup, icons, logo alignment, or responsive behavior—must be compared with the published reference before deciding whether to preserve or fix them.
