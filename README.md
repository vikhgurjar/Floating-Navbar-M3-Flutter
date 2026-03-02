# 🚀 Animated Floating Bottom Navbar M3 Expressive(Flutter)
<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg"/>
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter"/>
  <img src="https://img.shields.io/badge/Animation-Physics%20Driven-purple"/>
  <img src="https://img.shields.io/badge/UX-Premium-green"/>
</p>

A fully custom, physics-driven floating bottom navigation bar built with
Flutter.

This navbar goes beyond the default `BottomNavigationBar` and delivers
premium UX motion with morphing transitions, scroll-aware behavior, and
physics-based animation.

![Screenshot](https://github.com/user-attachments/assets/80563086-4459-4cb3-bf15-a7917c367edd)

------------------------------------------------------------------------

## ✨ Features

-   🎯 Pill-style selected tab
-   🔄 True shared-axis morph animation
-   🚀 FAB expands into selected pill dynamically
-   🧲 Magnetic snapping effect
-   🌊 Physics-based spring animations
-   📱 Fully touch-sensitive (optimized hit testing)
-   🏷 Icon + label layout (responsive & overflow-safe)
-   🎨 Dynamic color shift per tab
-   🌫 Subtle dark glass effect
-   📉 Hide on scroll (40px threshold detection)
-   ⚡ Micro-interaction polish
-   🧼 No background container artifacts

------------------------------------------------------------------------

## 📸 Demo

https://github.com/user-attachments/assets/ae45466f-a230-4010-8a07-ab3345f1676f


| Feature                  | Preview                      |
| ------------------------ | ---------------------------- |
| Pill morph animation     | Smooth shared-axis expansion |
| FAB → Tab transformation | Dynamic width growth         |
| Elastic spring switch    | Natural bounce physics       |
| Scroll hide (40px)       | Threshold-based smooth hide  |
| Dynamic color shift      | Per-tab accent blending      |


------------------------------------------------------------------------

## 🧠 Scroll Threshold (40px)

Navbar hides only after the user scrolls more than 40px to prevent
accidental hiding.

------------------------------------------------------------------------

## 🎨 Customization

You can easily modify:

-   Tab colors
-   Spring curve
-   Border radius
-   Blur intensity
-   Hide threshold
-   Animation duration
-   Label style
-   Icon size

------------------------------------------------------------------------

## 🛠️ Installation

1. **Clone the repository**
   
```bash
git clone https://github.com/Damantha126/Floating-Navbar-M3
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run   
```

Copy the navbar widget into your project and use:

``` dart
Scaffold(
  body: _pages[_currentIndex],
  bottomNavigationBar: CustomFloatingNavbar(),
)
```

------------------------------------------------------------------------

## 📄 Make Pages Scrollable (Required for Hide-on-Scroll)

``` dart
final ScrollController _scrollController = ScrollController();

@override
void initState() {
  super.initState();
  _scrollController.addListener(_onScroll);
}
```

Wrap page content:

``` dart
SingleChildScrollView(
  controller: _scrollController,
  child: Column(
    children: List.generate(
      30,
      (index) => ListTile(title: Text("Item $index")),
    ),
  ),
)
```

------------------------------------------------------------------------

## 🛠 Requirements

-   Flutter 3.x+
-   Dart 3.x

------------------------------------------------------------------------

## 📜 License

MIT License --- free to use, modify, and improve.

------------------------------------------------------------------------

Crafted for smooth motion, premium feel, and next-gen Flutter UI
experiences.

## 🔗 Links

- **Portfolio: [damanthaja.dev](https://www.damanthaja.dev)**
- **LinkedIn: [linkedin.com/in/damanthajasinghe](https://www.linkedin.com/in/damanthajasinghe/)**

**_Developed with ❤️ by ![Damantha Jasinghe](https://github.com/Damantha126)_**
