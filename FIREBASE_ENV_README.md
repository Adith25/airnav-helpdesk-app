# Firebase Environment Configuration

## Overview
Firebase API keys and configuration have been moved from hardcoded values to environment variables for better security. The values are **obfuscated** in the generated code using XOR encryption, making them safe to commit to version control.

## Setup Instructions

### 1. Environment File
The `.env` file contains all Firebase configuration values. This file is **not committed to version control** (listed in `.gitignore`).

### 2. Configuration Files
- **`.env`** - Contains actual Firebase configuration (secret, not committed)
- **`.env.example`** - Template file showing required variables (committed to repo)
- **`lib/core/config/env_config.dart`** - Environment config class with obfuscation enabled
- **`lib/core/config/env_config.g.dart`** - Generated file with **obfuscated** values (safe to commit)
- **`lib/firebase_options.dart`** - Firebase options using environment variables

### 3. First-time Setup
When cloning the repository:
```bash
# Copy the example file
cp .env.example .env

# Edit .env and fill in your Firebase credentials
# Contact the team for actual values

# Generate the obfuscated config
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Regenerating Environment Config
If you modify `.env` or `env_config.dart`:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Environment Variables
The following variables are required in `.env`:

```
FIREBASE_ANDROID_API_KEY=...
FIREBASE_ANDROID_APP_ID=...
FIREBASE_IOS_API_KEY=...
FIREBASE_IOS_APP_ID=...
FIREBASE_MESSAGING_SENDER_ID=...
FIREBASE_PROJECT_ID=...
FIREBASE_STORAGE_BUCKET=...
FIREBASE_IOS_BUNDLE_ID=...
```

## Security Features

### Obfuscation
All sensitive values use the `obfuscate: true` parameter in the `@EnviedField` annotations. This means:
- Values in `env_config.g.dart` are XOR-encrypted at build time
- The generated file contains obfuscated integer arrays, not plain text
- **The generated `.g.dart` file is SAFE to commit** to version control
- Actual values are only readable at runtime when the app decrypts them

### What's Safe to Commit?
✅ **SAFE to commit:**
- `.env.example` (template with no real values)
- `env_config.dart` (configuration class)
- `env_config.g.dart` (contains obfuscated values)
- `firebase_options.dart` (uses EnvConfig references)

❌ **NEVER commit:**
- `.env` (contains plain text secrets)

## Package Used
This implementation uses the `envied` package which provides:
- Type-safe environment variables
- Compile-time code generation with obfuscation
- XOR encryption of sensitive values
- Better security than runtime .env loading

