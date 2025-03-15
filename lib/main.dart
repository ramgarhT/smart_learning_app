import 'package:ai_learning_app/pages/splashScreen.dart';
import 'package:ai_learning_app/pages/users/signin_page.dart';
import 'package:ai_learning_app/pages/users/signup_page.dart';
import 'package:ai_learning_app/pages/users/user_homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  // Request Notification Permission
  FirebaseMessaging.instance.requestPermission();

  // Handle messages when app is in background
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("New notification: ${message.notification?.title}");
  });
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      home: SplashScreen(),
    );
  }
}
