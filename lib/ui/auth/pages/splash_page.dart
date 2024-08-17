import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../home/pages/home_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final session = supabase.auth.currentSession;

    return session == null ? const LoginPage() : const HomePage();
  }
}
