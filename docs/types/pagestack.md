---
title: CutiePageStack QML Type
---

CutiePageStack is a swipeable container for navigating between [CutiePage](page) items.

### Functions

- `push(page, properties)`: add and show a page.
- `pop(page)`: return to the previous page, or to the page before `page` when provided.
- `replaceTop(page, properties)`: replace the top page.
- `removeTop()`: remove pages above the current page.
- `clear()`: clear the stack's content.

## Detailed Description

Swipe navigation is enabled by default. The current page's `swipeNavigationEnabled` property controls whether users can swipe between pages. Set it to `false` for pages that capture horizontal gestures, such as a pattern entry page. This does not prevent navigation through the stack's functions.
