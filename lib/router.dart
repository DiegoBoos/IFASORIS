import 'package:flutter/material.dart';
import 'package:ifasoris/ui/ficha/pages/componentes_grupo_familiar_page.dart';

import 'ui/auth/pages/sign_in_page.dart';
import 'ui/home/pages/home_page.dart';
import 'ui/ficha/pages/ficha_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInPage(),
    'home': (BuildContext context) => const HomePage(),
    'ficha': (BuildContext context) => const FichaPage(),
    'componentes': (BuildContext context) =>
        const ComponentesGrupoFamiliarPage(),
  };
}
