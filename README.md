# MOE

## Installation
### Prerequisites
- Flutter (Latest stable version) installed
- Dart SDK installed
- AWS Amplify CLI installed (`npm install -g @aws-amplify/cli`)

### Steps to Set Up
1. Clone this repository:
   ```sh
   git clone https://github.com/nineti-GmbH/moe
   cd moe
   ```

2. Install dependencies:
   ```sh
   dart pub get
   ```

3. Initialize AWS Amplify:
   ```sh
   amplify init
   amplify add auth
   amplify push
   ```

4. Run the application:
   ```sh
   flutter run
   ```

## Project Structure
```
lib/
|-- <feature>/           # Feature-based structure
|   |-- bloc/            # BLoC state management
|   |-- repos/           # Authentication and API logic
|   |-- screens/         # UI screens
|   |-- widgets/         # Reusable widgets
|-- l10n/                # Localization files
|   |-- app_en.arb       # English localization file
|   |-- app_de.arb       # German localization file
|   |-- l10n.dart        # Localization setup
|-- main.dart            # App entry point

assets/
|-- l10n/                # (Optional) Store additional localization assets

test/
|-- <feature>/           # Feature-based structure
|   |-- bloc/            # BLoC state management tests
|   |-- repos/           # Authentication and API logic tests
|   |-- screens/         # UI screen tests
|   |-- widgets/         # Widget tests
```

## Features
- Authentication using AWS Amplify
- BLoC state management
- Automated testing (unit & integration tests)
- Localization support

## Commit Rules
This project follows **commitlint common rules**, ensuring all commit messages are in **lowercase** and follow the format:
```
<type>: <action> <subject>
```
Examples:
- `feat: add authentication`
- `fix: resolve auth session issue`

### Additional Rules
- Test cases will be **automatically performed** before allowing a commit.
- Even warnings will **stop the commit** process until they are resolved.
- Add Strings with proper ID in the app_en and app_de files.
   ```sh
   flutter gen-l10n
   ```

## Testing
To run tests:
```sh
flutter test
```

## Contributing
1. Fork the repository.
2. Create a new feature branch (`git checkout -b feature-name`).
3. Commit changes (`git commit -m "feat: add new feature"`).
4. Push to your branch (`git push origin feature-name`).
5. Open a Pull Request.

## License
MOE is © Copyright Nineti GmbH. All rights reserved.

