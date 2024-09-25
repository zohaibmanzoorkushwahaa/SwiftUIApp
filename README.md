# SwiftUI App with Firebase Authentication and UIPilot Navigation

This is a SwiftUI-based mobile app that implements email/password sign-in and sign-up functionality using Firebase Authentication. The app is structured using the MVVM (Model-View-ViewModel) architecture, and navigation is managed with `UIPilot`, a SwiftUI navigation library.

## Features

- **SwiftUI Interface**: A fully SwiftUI-based user interface for seamless performance and modern iOS design.
- **Firebase Authentication**: Users can sign in and sign up using their email and password via Firebase.
- **MVVM Architecture**: Follows the MVVM pattern to ensure a clean and maintainable codebase.
- **UIPilot for Navigation**: Provides a simplified, declarative navigation structure between different views.

## Project Structure

```plaintext
├── Models
│   └── User.swift             # Model representing the user data
├── ViewModels
│   ├── AuthViewModel.swift     # ViewModel handling authentication logic
│   └── SignupViewModel.swift   # ViewModel handling signup logic
├── Views
│   ├── LoginView.swift         # SwiftUI view for the login screen
│   └── SignupView.swift        # SwiftUI view for the sign-up screen
├── Services
│   └── FirebaseAuthService.swift  # Handles Firebase authentication interactions
├── Navigation
│   └── UIPilotNavigator.swift  # UIPilot navigator handling screen transitions
└── Resources
    └── README.md               # Project documentation
