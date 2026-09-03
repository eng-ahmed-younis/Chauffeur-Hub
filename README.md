# Chauffeur Hub

**Chauffeur Hub** is a premium, high-end mobile application built with Flutter for elite chauffeur services. It delivers a seamless, secure, and sophisticated experience for drivers and clients, featuring robust session management, clean architecture, and responsive luxury UI design.

---

## ✨ Key Features

- **Luxury Splash Screen & Branding**: Animated entrance with a custom glowing emblem, gradient theme (`#0B132B` to `#1C2541`), and gold accents (`#D4AF37`).
- **Secure Authentication & Session Management**: Powered by `SessionController`, `SecureSessionStore`, and encrypted local storage (`flutter_secure_storage`).
- **Declarative Routing**: Type-safe navigation and automatic auth guards using `GoRouter`.
- **Responsive Design**: Fluid adaptation across mobile devices using `flutter_screenutil`.
- **Robust Networking**: REST API integration via `Dio` equipped with logging and interceptors.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: Flutter (`^3.13.2`) / Dart
- **Architecture**: Feature-First Clean Architecture
- **Dependency Injection**: `get_it`
- **State Management**: `ChangeNotifier` / Reactive State Controllers
- **Routing**: `go_router`
- **Storage**: `flutter_secure_storage` & `shared_preferences`

---

## 📁 Project Structure

```text
lib/
├── app/                  # App root and global configuration (ChauffeurApp.dart)
├── core/                 # Shared core utilities, DI, network, storage, theme, and routers
│   ├── services/         # Service locators (GetIt) and GoRouter configuration
│   ├── storage/          # Session management (SessionController, SessionStore)
│   └── widgets/          # Reusable shared UI components
└── features/             # Feature-based modules
    ├── auth/             # Authentication feature (Login, OTP, Reset Password)
    └── splash/           # Splash screen and initialization logic
```

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.13.2`)
- Dart SDK
- Android Studio / Xcode (for iOS and Android emulators/devices)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/chauffeur_hub.git
   cd chauffeur_hub
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

---

## 📄 License

This project is private and proprietary to Chauffeur Hub.
