import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../utils/network_icon.dart';
import '../widgets/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthLoaded) {
            Navigator.pushReplacementNamed(context, 'home');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: Colors.red));
          }
        }),
      ],
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            const SizedBox(height: 30),
            Image.asset(
              'assets/icon_foreground.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                Text('IFASORIS', style: Theme.of(context).textTheme.headline4),
                const Expanded(child: NetworkIcon())
              ],
            ),
            const SizedBox(height: 30),
            const SignInForm(),
          ],
        ),
      ),
    );
  }
}
