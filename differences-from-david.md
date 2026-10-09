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

The `html` halftone background has now been restored from the current original CSS, with the exact GIF copied into `media/icon/halftone.gif` and a Jekyll `relative_url` so it works under the project's `/d00-jk-bc` base path. See commit [18d93d4](https://github.com/devAItester/d00-jk-bc/commit/18d93d4a4c2bc764b32555d2ab47fbf9ca18526e).

Other confirmed mismatches still need decisions or fixes:

- `body` uses `min-height:100vh` instead of `min-height:calc(100vh - 15px)`.
- CSS Grid replaces the original float-based header and normal-flow navigation; this remains a workaround, not an approved design difference.
- Footer geometry differs: the original uses `height:60px; overflow:hidden` and styles all direct children as 30px inline-blocks; ours uses `min-height:60px` and lacks the original child layout rules.
- Our footer HTML is intentionally much simpler than the original footer and omits its icon links and right-aligned group; visual equivalence is not yet established.
- Our header logo is an SVG asset with explicit 200 × 42 dimensions, while the current original page uses a PNG logo with width 200 and intrinsic height.
- Our layout adds `<meta name="color-scheme" content="light dark">`, which is absent from the original page template.

These are observations, not automatically intentional differences. Resolve them by checking the live reference and historical source before changing them.

## Implementation approach

The project uses Jekyll, Markdown files, and Liquid templates to reproduce the file-oriented navigation model. The directory tree supplies the content hierarchy, and Jekyll generates static HTML. This is an implementation choice; it does not by itself justify visual differences from David's site.

## Verification rule

Only differences explicitly described as deliberate above are accepted design deviations. Other mismatches—such as list spacing, page markup, icons, logo alignment, or responsive behavior—must be compared with the published reference before deciding whether to preserve or fix them.
