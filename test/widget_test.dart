import 'package:airnav_helpdesk/core/services/theme_service.dart';
import 'package:airnav_helpdesk/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock path_provider channel because GetStorage uses it
    const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '.'; // Return current directory as a mock path
      },
    );

    // Initialize GetStorage
    await GetStorage.init();
  });

  testWidgets('MainApp smoke test', (WidgetTester tester) async {
    // Inject ThemeService before building MainApp
    // We create a new instance for each test to ensure clean state
    Get.put(ThemeService());

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());

    // Verify that the MainApp widget is present in the tree.
    // This ensures the app initializes without throwing an error immediately.
    expect(find.byType(MainApp), findsOneWidget);
    
    // Clean up GetX dependencies
    Get.delete<ThemeService>();
  });
}
