import 'package:flutter/material.dart';
import 'package:ifasoris/ui/auth/pages/login_page.dart';
import 'package:ifasoris/ui/home/pages/home_page.dart';

import '../../../core/constants.dart';

/// Page to redirect users to the appropriate page depending on the initial auth state
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.of(context)
          .pushAndRemoveUntil(LoginPage.route(), (route) => false);
    } else {
      Navigator.of(context)
          .pushAndRemoveUntil(HomePage.route(), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
}
