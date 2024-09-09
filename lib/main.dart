import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/login_screen.dart';
import 'package:flutter_application_1/View/splash_screen.dart';
import 'package:flutter_application_1/View/welcome_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/welcome',
          page: () => WelcomeScreen(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          transition: Transition.zoom,
        ),
      ],
      home: SplashScreen(),
    );
  }
}
