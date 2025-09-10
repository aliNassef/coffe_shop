# Coffee Shop Flutter App

A feature-rich coffee shop application built with Flutter. This app provides a seamless experience for users to discover nearby coffee shops, browse menus, place orders, and track them in real-time. It is built with a focus on clean architecture, scalability, and a high-quality user experience.

## 🌟 Features

-   **User Authentication**: Secure sign-up and login functionality using Firebase Authentication.
-   **Interactive Map**: Discover nearby coffee shops on an interactive map powered by Google Maps.
-   **Real-time Order Tracking**: Live tracking of order delivery on the map.
-   **Menu Browsing**: Smoothly browse coffee menus with images cached for performance.
-   **Address Management**: Easily pick and save delivery addresses using a location picker.
-   **Responsive UI**: The interface is designed to adapt beautifully to various screen sizes using `flutter_screenutil`.
-   **Offline Handling**: Gracefully handles offline scenarios, notifying the user of connectivity issues.
-   **Error Monitoring**: Integrated with Sentry for real-time crash reporting and issue tracking in production.
-   **Loading Skeletons**: Displays skeleton loaders while data is being fetched for an improved UX.
-   **Environment-based Configuration**: Manages API keys and other sensitive data securely using `envied`.

## 🏗️ Architecture

This project follows the principles of **Clean Architecture** to ensure a clear separation of concerns, making the codebase scalable, testable, and maintainable. The architecture is divided into three primary layers:

-   **Presentation Layer**: Contains the UI (Widgets) and the state management logic (BLoCs/Cubits). It is responsible for displaying data and handling user input.
-   **Domain Layer**: The core of the application. It contains the business logic, use cases, and entity definitions. This layer is independent of any framework.
-   **Data Layer**: Responsible for data retrieval from various sources, such as remote APIs (Firebase) and local storage (SharedPreferences). It implements the repositories defined in the domain layer.

### State Management

**BLoC (Business Logic Component)** is used for state management. This pattern helps in separating the presentation from the business logic, leading to a more structured and predictable state flow throughout the application.

## 🛠️ Technologies & Libraries

-   **State Management**: `bloc`, `flutter_bloc`
-   **Backend & Database**: `firebase_core`, `firebase_auth`, `cloud_firestore`
-   **Dependency Injection**: `get_it`
-   **Location & Maps**: `google_maps_flutter`, `geolocator`, `geocoding`, `flutter_polyline_points`
-   **Networking & Connectivity**: `internet_connection_checker_plus`
-   **Error Reporting**: `sentry_flutter`
-   **UI & UX**:
    -   `flutter_screenutil` (Responsive UI)
    -   `cached_network_image` (Image Caching)
    -   `skeletonizer` (Loading Skeletons)
    -   `fluttertoast` (Toast Notifications)
    -   `google_fonts` (Custom Fonts)
-   **Functional Programming**: `dartz`, `equatable`
-   **Environment Variables**: `envied`

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

-   Flutter SDK (version 3.9.0 or higher)
-   An editor like VS Code or Android Studio
-   A configured Firebase project
-   A Google Maps API key

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-repository/coffe_shop.git
    cd coffe_shop
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Setup Environment Variables:**
    This project uses the `envied` package to manage environment variables. You need to create a `.env` file in the root of the project.

    Create a file named `.env` in the project root and add your Firebase and Google Maps API keys:
    ```env
    # Sentry DSN for error reporting
    SENTRY_DSN=YOUR_SENTRY_DSN

    # Google Maps API Key
    GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY
    ```
    *Note: You will need to enable the Maps SDK for Android/iOS and the Geocoding API in your Google Cloud Platform project.*

4.  **Generate the environment file:**
    Run the build runner to generate the `lib/env/env.g.dart` file:
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  **Setup Firebase:**
    -   Follow the instructions to add this app to your Firebase project: Firebase Docs
    -   Download your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the appropriate directories.

6.  **Run the app:**
    ```sh
    flutter run
    ```

## 📁 Project Structure

The project is structured following Clean Architecture principles to maintain a clean and organized codebase.

```
lib/
├── coffe_shop_app.dart     # Main application widget
├── main.dart               # App entry point
├──
├── core/                   # Core utilities, services, and shared components
│   ├── di/                 # Dependency injection setup (GetIt)
│   ├── controller/         # App-wide BLoCs/Cubits (e.g., User, Internet)
│   ├── utils/              # Utility classes and functions
│   └── widgets/            # Shared custom widgets
│
├── data/                   # Data layer
│   ├── datasources/        # Remote and local data sources
│   ├── models/             # Data models (for JSON serialization)
│   └── repositories/       # Implementation of domain repositories
│
├── domain/                 # Domain layer
│   ├── entities/           # Business objects/entities
│   ├── repositories/       # Abstract repository contracts
│   └── usecases/           # Application-specific business rules
│
├── features/               # Feature-based modules
│   └── feature_name/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── view/       # UI screens/views
│           ├── view_model/ # BLoCs/Cubits for the feature
│           └── widgets/    # Feature-specific widgets
│
└── env/                    # Environment variables configuration
```

## 🧪 Testing

This project is configured for unit and widget testing to ensure code quality and prevent regressions. The setup includes:
-   `flutter_test`: The core framework for testing Flutter apps.
-   `bloc_test`: Simplifies testing of BLoCs and Cubits.
-   `mockito`: A powerful mocking framework to create mock dependencies for tests.

Tests should be located in the `test/` directory (following Dart conventions) and can be run with:
```sh
flutter test
```

## 🚀 Continuous Integration & Deployment (CI/CD) with Fastlane

**Fastlane** is integrated into the project to automate the build and release process. The `android/fastlane/` directory contains a `distribute` lane that builds the app and uploads it to Firebase App Distribution.

A crucial improvement is to **add a testing step to the Fastlane `distribute` lane**. This ensures that you only distribute builds that have passed all tests, maintaining a high quality bar. You can modify your `android/fastlane/Fastfile` to include `flutter test` before the build step.

