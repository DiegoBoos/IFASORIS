import 'package:flutter/material.dart';

import 'ui/auth/pages/sign_in_page.dart';
import 'ui/tabs/pages/tabs_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInPage(),
    'tabs': (BuildContext context) => const TabsPage(),
  };
}
