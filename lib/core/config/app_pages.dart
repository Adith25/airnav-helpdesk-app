import 'package:get/get.dart';

import '../../main_binding.dart';
import '../../main_page.dart';

part 'app_routes.dart';

class AppPages{
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Path.MAIN,
      page: () => const MainPage(),
      binding: MainBinding(),),
  ];
}


