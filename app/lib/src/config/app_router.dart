import 'package:flutter/material.dart';

import '../authentication/pages/login_page.dart';
import '../home/home_page.dart';
import '../splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginPage(),
    home: (context) => const HomePage(),
  };
}
