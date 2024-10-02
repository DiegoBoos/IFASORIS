import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../utils/network_icon.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => const RegisterPage(),
    );
  }

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Registered) {
            Navigator.pushNamed(context, 'login');
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
                      style: Theme.of(context).textTheme.headline4),
                  const Expanded(child: NetworkIcon())
                ],
              ),
              const SizedBox(height: 30),
              const RegisterForm(),
              Center(
                  child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: const Text('Ya tiene una cuenta? Inicie sesión',
                    style: TextStyle(color: Colors.green)),
              )),
            ],
          ),
        ));
  }
}
