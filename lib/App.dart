import 'package:firebase_series/controller/authController.dart';
import 'package:firebase_series/screen/LoadingScreen.dart';
import 'package:firebase_series/screen/homeScreen.dart';
import 'package:firebase_series/screen/login.dart';
import 'package:firebase_series/theme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding:BindingsBuilder.put(()=>Get.put(AuthController()),// Register AuthController with GetX // this binding for controller init or start after app start
),
      navigatorKey: Get.key,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      // home: LoginScreen(),
      getPages: [
        GetPage(name: '/', page: () => LoadingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
