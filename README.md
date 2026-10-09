# 🥃 Premium Spirits - E-Commerce App

A beautifully designed mobile application built with Flutter for browsing and purchasing premium alcoholic beverages, such as aged single malt scotch and fine wines. 

This repository represents the **Milestone 1 (MVP UI layout)** for the Final Capstone Project.

## 🎯 Milestone 1 Requirements Fulfilled

This project fully implements the Weeks 1–5 curriculum requirements:

- [x] **Main Discovery/Feed Screen (`feed_screen.dart`):** 
  - Implements `Column` and `Row` for structural layout.
  - Utilizes custom `Card` widgets to display featured collections and products.
- [x] **Adaptive Item Detail Screen (`product_detail_screen.dart`):** 
  - Uses `Stack` to overlay a bookmark badge on top of the product cover image.
  - Arranges product title, star rating, price, and category tags using `Row` and `Wrap`.
  - Includes a bottom sticky action bar with an "Add to Cart" button occupying full width via `Expanded`.
- [x] **Working Interactivity (StatefulWidget):** 
  - The Item Detail Screen is a `StatefulWidget`.
  - The Favorite/Bookmark icon toggle is fully interactive and updates the UI state using `setState()`.
- [x] **Responsive & Error-Free Layout:** 
  - Implemented `SingleChildScrollView` alongside `Expanded` to ensure **zero RenderFlex overflow** across both small and large device screens.
- [x] **Code Cleanliness & Architecture:** 
  - Code is strictly separated into logical directories (`lib/screens` and `lib/widgets`).

## 📂 Folder Architecture

```text
lib/
├── main.dart
├── screens/
│   ├── feed_screen.dart           # Discovery screen with product list
│   └── product_detail_screen.dart # Detailed product view with interactivity
└── widgets/
    └── product_card.dart          # Reusable UI component for the feed
