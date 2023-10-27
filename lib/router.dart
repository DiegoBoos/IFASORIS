import 'package:flutter/material.dart';

import 'ui/auth/pages/sign_in_page.dart';
import 'ui/ficha/pages/atencion_salud_page.dart';
import 'ui/ficha/pages/cuidado_salud_cond_riesgo_page.dart';
import 'ui/ficha/pages/dimension_sociocultural_pueblos_indigenas_page.dart';
import 'ui/ficha/pages/estilos_vida_saludable_page.dart';
import 'ui/home/pages/cambio_dispositivo_page.dart';
import 'ui/home/pages/home_page.dart';
import 'ui/ficha/pages/ficha_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInPage(),
    'home': (BuildContext context) => const HomePage(),
    'cambio-dispositivo': (BuildContext context) =>
        const CambioDispositivoPage(),
    'ficha': (BuildContext context) => const FichaPage(),
    'estilo-vida-saludable': (BuildContext context) =>
        const EstilosVidaSaludablePage(),
    'cuidado-salud-cond-riesgo': (BuildContext context) =>
        const CuidadoSaludCondRiesgoPage(),
    'dimension-sociocultural-pueblos-indigenas': (BuildContext context) =>
        const DimensionSocioCulturalPueblosIndigenasPage(),
    'atenciones-en-salud': (BuildContext context) => const AtencionSaludPage(),
  };
}
