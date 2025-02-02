import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../utils/network_icon.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            Navigator.pushNamed(context, 'home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: Colors.red));
          }
        },
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              Image.asset(
                'assets/icon/icon_foreground.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  Text('IFASORIS',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const Expanded(child: NetworkIcon())
                ],
              ),
              const SizedBox(height: 30),
              const LoginForm(),
            ],
          ),
        ));
  }
}
