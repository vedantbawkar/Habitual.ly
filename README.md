# Habitual.ly - Daily Habit Tracker

A beautiful and modern habit tracking app built with Flutter that helps users form and maintain daily habits through an engaging reward system and social features.

## Features

### Core Functionality
- 📝 Create and manage daily habits
- ✅ Track habit completion
- 📊 Daily progress visualization
- 🔄 Clear completed habits to start fresh

### Reward System
- 🪙 Earn coins for completing habits (5 coins per habit)
- 🎯 Daily coin limit of 25 to encourage balanced progress
- 🔥 Build streaks by maintaining daily consistency
- ⭐ Tips and motivation to keep users engaged

### Social Features
- 👥 Add and view friends
- 🏃‍♂️ Track friends' streaks
- 👋 Easy friend discovery
- 📊 Compare progress with friends

### UI/UX Features
- 🎨 Modern gradient design
- 💫 Smooth animations
- 🌗 Clean, minimalist interface
- 📱 Responsive layout
- 🎯 Progress indicators

## Technical Details

### Built With
- Flutter - UI framework
- Material Design - Design system
- Google Fonts (Poppins) - Typography
- Device Preview - Testing responsiveness

### Project Structure
```
lib/
├── main.dart           # App entry point and main screen
├── models/
│   └── habit.dart      # Habit data model
├── pages/
│   ├── add_friends.dart # Friends management
│   └── profile.dart    # User profile
└── widgets/
    ├── habit_tile.dart  # Habit list item
    └── progress_indicator.dart # Progress visualization
```

### State Management
- Local state management using `setState`
- Persistent storage (upcoming)
- Friend system implementation (in progress)

## Getting Started

### Prerequisites
- Flutter (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
```powershell
git clone https://github.com/vedantbawkar/Habitual.ly
```

2. Navigate to the project directory
```powershell
cd habitually
```

3. Install dependencies
```powershell
flutter pub get
```

4. Run the app
```powershell
flutter run
```

## Roadmap

- [ ] Data persistence
- [ ] Achievement system
- [ ] Enhanced social features
- [ ] Theme
- [ ] Statistics and analytics

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Icons and design inspiration from Material Design
- Flutter community for valuable widgets and packages
- Contributors and testers
