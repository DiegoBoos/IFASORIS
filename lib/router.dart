import 'package:flutter/material.dart';

import 'ui/auth/pages/login_page.dart';
import 'ui/auth/pages/register_page.dart';
import 'ui/auth/pages/splash_page.dart';
import 'ui/home/pages/home_page.dart';
import 'ui/ficha/pages/ficha_page.dart';

class AppRouter {
  static const initialRoute = 'splash';

  static Map<String, Widget Function(BuildContext)> routes = {
    'splash': (BuildContext context) => const SplashPage(),
    'login': (BuildContext context) => const LoginPage(),
    'register': (BuildContext context) => const RegisterPage(),
    'home': (BuildContext context) => const HomePage(),
    'ficha': (BuildContext context) => const FichaPage(),
  };
}
