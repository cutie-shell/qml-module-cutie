---
title: CutieSearchBox QML Type
---

CutieSearchBox is a rounded search field that follows the Cutie theme.

Inherits: [CutieTextField](#)

## Detailed Description

The component uses `Atmosphere.textColor` for its placeholder text, has a rounded `Atmosphere.primaryAlphaColor` background, and provides horizontal padding. Its text, placeholder, and signals come from `CutieTextField`.

```qml
CutieSearchBox {
    placeholderText: qsTr("Search songs...")
    onAccepted: view.searchQuery = text
}
```
