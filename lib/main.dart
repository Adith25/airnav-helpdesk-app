import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title:'Helpdesk',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

