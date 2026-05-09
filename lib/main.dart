import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_series/App.dart';
import 'package:firebase_series/controller/authController.dart';
import 'package:firebase_series/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // AuthController(); // Initialize AuthController
  Get.put(AuthController()); // Register AuthController with GetX
  runApp(const MyApp());
}
