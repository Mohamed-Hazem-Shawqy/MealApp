🍽️ Meal App

A Flutter-based mobile application for browsing, recognizing, and managing meals. Built with BLoC state management, MVVM architecture,
Supabase Authentication & Storage, and Gemini AI for smart meal recognition.
---------------------------
🚀 Features

🔐 Authentication

Supabase Email/Password

Google Sign-In

📦 Cloud Storage with Supabase (meal images, user data).a

🧑‍💻 State Management: BLoC.

🏗️ MVVM Architecture: clear separation of Data, Domain, and View layers.

🤖 Gemini AI Meal Recognition: upload an image → get meal name, ingredients, nutrition, and summary.

🎨 Custom UI with splash screen, onboarding, and Google Nav Bar.
-------------------------------------

🛠️ Tech Stack


Flutter (UI framework)

Dart (language)

flutter_bloc → predictable state management

go_router → declarative navigation

supabase_flutter → authentication & storage

google_sign_in → Google login

google_generative_ai → Gemini AI API integration

app_links → deep linking support

equatable → value equality for entities

json_serializable / json_annotation → code generation for models

flutter_native_splash → custom splash screen

google_nav_bar → bottom navigation bar

-------------------------------------------
📂 Project Structure
lib/
│── core/                  # Constants, themes, helpers
│── features/
│   ├── authentication/    # Supabase + Google sign-in
│   ├── productdetails/
│   │   ├── data/          # Models, API & Supabase services
│   │   ├── domain/        # Entities & UseCases
│   │   ├── view/          # UI Screens & Widgets
│── main.dart
-------------------------------------------
📸 Assets

The app includes onboarding & UI assets:

🍕 pizza-pizza-filled-with-tomatoes-salami-olives.png

🥩 well-done-steak-homemade-potatoes.png

👨‍🍳 Chef Hat.png

🎨 Ellipse background assets
====================================


🤝 Contribution

Fork the repo

Create a new branch (feature/your-feature)

Commit changes

Push and create a Pull Request

----------------------------------------
[Watch Demo Video on Google Drive](https://drive.google.com/file/d/1yO5wcC34DdoMUz_yf2g58u0Dp6_yxGYI/view?usp=sharing)




