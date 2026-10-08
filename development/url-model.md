---
layout: default
title: url model
---

# URL model

The reference deliberately separates navigation hierarchy from public URL.

Example:

    software
      utilities
        catclock

is navigation classification. The public address is /catclock.html, not /software/utilities/catclock.html.

The same applies to utilities: it is under software in the menu, while its public address is /utilities.html.

Therefore menu path and URL path are independent.

The architecture has three layers:

    source tree
        ↓
    navigation tree
        ↓
    page URL

The navigation answers where material belongs. The URL answers how to address the page uniquely.

For a long IT chain:

    it
      linux
        cli
          utilities
            yazi

The source may be it/linux/cli/utilities/yazi.md while the public URL may be /yazi.html.

In Jekyll the navigation algorithm may use the source tree to determine relationships, but the link itself must use the generated page URL:

    <a href="{{ p.url | relative_url }}">...</a>

Do not reconstruct the URL from navigation labels.

A hierarchical URL such as /it/linux/cli/utilities/yazi.html is also valid, but it is a design choice, not a consequence of hierarchical navigation.

Verification:

    menu href
        ↓
    actual URL
        ↓
    generated HTML

The test must verify the actual generated address rather than guessing it from the menu path.
