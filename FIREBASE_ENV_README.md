# Firebase Environment Configuration

## Overview
Firebase API keys and configuration have been moved from hardcoded values to environment variables for better security.

## Setup Instructions

### 1. Environment File
The `.env` file contains all Firebase configuration values. This file is **not committed to version control** (listed in `.gitignore`).

### 2. Configuration Files
- **`.env`** - Contains actual Firebase configuration (secret, not committed)
- **`.env.example`** - Template file showing required variables (committed to repo)
- **`lib/core/config/env_config.dart`** - Environment config class
- **`lib/firebase_options.dart`** - Firebase options using environment variables

### 3. First-time Setup
When cloning the repository:
```bash
# Copy the example file
cp .env.example .env

# Edit .env and fill in your Firebase credentials
# Contact the team for actual values
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

## Security Notes
- **Never commit `.env`** to version control
- Keep API keys confidential
- Use different credentials for development, staging, and production environments

## Package Used
This implementation uses the `envied` package which provides:
- Type-safe environment variables
- Compile-time code generation
- Better performance than runtime .env loading
