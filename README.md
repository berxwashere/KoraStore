# <img src="assets/images/kora-logo.svg" width="40" height="40" alt="Kora Logo"> Kora - Modern E-Commerce Application

Kora is a premium, high-performance mobile e-commerce application built with **Flutter**. It features a modern design system, seamless navigation, and a robust architecture to provide a top-tier shopping experience.

---

## 🌟 Key Features
- 🎨 **Modern UI/UX:** Clean, minimal, and premium interface designed with Inter typography.
- 🔍 **Product Discovery:** Dynamic product listing and categorized browsing.
- 📄 **Detailed Views:** Rich product detail pages with comprehensive information and image support.
- 🛒 **Shopping Cart:** Real-time cart management with instant updates.
- ❤️ **Favorites System:** Persistent wishlist to save your favorite items for later.
- 🔐 **Secure Login:** Integrated authentication flow with strict input validation and secure credential persistence.
- 🧭 **Seamless Navigation:** Intuitive bottom navigation bar for quick access to all major app sections.
- 📱 **Responsive Layout:** Pixel-perfect design optimized for various device resolutions.

---

## 🛠️ Tech Stack
- **Framework:** [Flutter](https://flutter.dev) (Cross-platform)
- **Language:** [Dart](https://dart.dev)
- **State Management:** [Provider](https://pub.dev/packages/provider)
- **Data Source:** [FakeStoreAPI](https://fakestoreapi.com) (REST API)
- **Typography:** [Google Fonts (Inter)](https://fonts.google.com/specimen/Inter)
- **Iconography:** [Flutter SVG](https://pub.dev/packages/flutter_svg)
- **Local Storage:** [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **Image Handling:** [Cached Network Image](https://pub.dev/packages/cached_network_image)

---

## ⚙️ Technical Specifications
- **Flutter SDK:** `3.41.6`
- **Dart SDK:** `3.11.4`
- **Architecture:** MVVM-inspired clean directory structure
- **UI System:** Material Design 3 with custom theme extensions
- **Assets:** Scalable vector-based iconography

---

## 📂 Project Structure
```text
lib/
├── models/
│   ├── cart_item.dart       # Cart item entity
│   └── product.dart         # Product data model
├── providers/
│   ├── cart_provider.dart      # Cart state & logic
│   ├── favorites_provider.dart # Wishlist management
│   └── product_provider.dart   # Product data handling
├── screens/
│   ├── login_screen.dart           # User authentication
│   ├── splash_screen.dart          # App entry animation
│   ├── main_shell.dart             # Bottom navigation host
│   ├── home_screen.dart            # Product feed
│   ├── product_detail_screen.dart  # Detailed product view
│   ├── cart_screen.dart            # Shopping cart UI
│   ├── favorites_screen.dart       # Saved items list
│   └── profile_screen.dart         # User settings & info
├── services/
│   ├── api_service.dart            # API communication logic
│   └── local_storage_service.dart  # Persistent storage (Pref)
├── theme/
│   └── app_theme.dart       # Design system, colors & fonts
├── widgets/
│   ├── navigation_item.dart # Custom nav components
│   └── product_card.dart    # Reusable product preview
└── main.dart                # Application entry point
```

---

## 📸 Screenshots

| Login Screen | Home Feed | Product Detail |
| :---: | :---: | :---: |
| ![Login] | ![Home] | ![Product] |

| Shopping Cart | Profile | Favorites |
| :---: | :---: | :---: |
| ![Cart] | ![Profile] | ![Favorites] |

<!-- [Login]: https://via.placeholder.com/200x400?text=Login+Screen
[Home]: https://via.placeholder.com/200x400?text=Home+Feed
[Product]: https://via.placeholder.com/200x400?text=Product+Detail
[Cart]: https://via.placeholder.com/200x400?text=Shopping+Cart
[Profile]: https://via.placeholder.com/200x400?text=User+Profile
[Favorites]: https://via.placeholder.com/200x400?text=Wishlist -->


---

## 🚀 Getting Started

Follow these steps to get the project running locally:

### 1. Prerequisites
Ensure you have Flutter installed on your machine. You can verify this by running:
```bash
flutter --version
```

### 2. Clone the Repository
```bash
git clone https://github.com/berxwashere/KoraStore.git
cd KoraStore
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run the Application
Connect your device or start an emulator/simulator, then run:
```bash
flutter run
```

---

## 🎓 Purpose
This project was developed as a comprehensive exercise to master the core principles of Flutter and to apply modern mobile application architecture in a professional, real-world scenario.
