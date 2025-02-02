import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/blocs/auth/auth_bloc.dart';

import '../../../services/shared_preferences_service.dart';
import '../../home/pages/home_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(CheckAuth());
  }

  final prefs = SharedPreferencesService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (prefs.token.isNotEmpty) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
