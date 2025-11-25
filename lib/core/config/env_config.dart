import 'package:envied/envied.dart';

part 'env_config.g.dart';

@Envied(path: '.env')
abstract class EnvConfig {
  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY')
  static const String firebaseAndroidApiKey = _EnvConfig.firebaseAndroidApiKey;

  @EnviedField(varName: 'FIREBASE_ANDROID_APP_ID')
  static const String firebaseAndroidAppId = _EnvConfig.firebaseAndroidAppId;

  @EnviedField(varName: 'FIREBASE_IOS_API_KEY')
  static const String firebaseIosApiKey = _EnvConfig.firebaseIosApiKey;

  @EnviedField(varName: 'FIREBASE_IOS_APP_ID')
  static const String firebaseIosAppId = _EnvConfig.firebaseIosAppId;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID')
  static const String firebaseMessagingSenderId =
      _EnvConfig.firebaseMessagingSenderId;

  @EnviedField(varName: 'FIREBASE_PROJECT_ID')
  static const String firebaseProjectId = _EnvConfig.firebaseProjectId;

  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET')
  static const String firebaseStorageBucket = _EnvConfig.firebaseStorageBucket;

  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID')
  static const String firebaseIosBundleId = _EnvConfig.firebaseIosBundleId;
}
