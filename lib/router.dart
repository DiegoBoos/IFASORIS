import 'package:flutter/material.dart';

import 'ui/auth/pages/sign_in_page.dart';
import 'ui/home/pages/home_page.dart';
import 'ui/ubicacion/pages/grupo_familiar_page.dart';
import 'ui/ubicacion/pages/search_afiliado_page.dart';
import 'ui/ubicacion/pages/ubicacion_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInPage(),
    'home': (BuildContext context) => const HomePage(),
    'ubicacion': (BuildContext context) => const UbicacionPage(),
    'search-afiliado': (BuildContext context) => const SearchAfiliadoPage(),
    'grupo-familiar': (BuildContext context) => const GrupoFamiliarPage(),
  };
}
