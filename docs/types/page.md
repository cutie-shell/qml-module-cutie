---
title: CutiePage QML Type
---

CutiePage is a page component designed to be used with [CutiePageStack](pagestack).

### Properties

- `swipeNavigationEnabled`: whether the user can navigate between pages by swiping. Defaults to `true`.

## Detailed Description

Set `swipeNavigationEnabled` to `false` on a page when horizontal touch gestures on that page must not navigate the page stack. The setting applies while the page is current. Programmatic navigation through `CutiePageStack.push()` and `CutiePageStack.pop()` remains available.

```qml
CutiePage {
    swipeNavigationEnabled: false
}
```
