import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../cubits/internet/internet_cubit.dart';
import '../../utils/network_icon.dart';
import '../widgets/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final configFormKey = GlobalKey<FormState>();

  final userNameCtrl = TextEditingController(text: 'jpalomino');
  final passwordCtrl = TextEditingController(text: 'Jpalomino*2022');

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    final internetCubit = BlocProvider.of<InternetCubit>(context);

    final size = MediaQuery.of(context).size;

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
          body: Center(
            child: Container(
              width: (size.width > 500) ? size.width / 2 : size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/icon_foreground.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Spacer(),
                        Text('Ingresar',
                            style: Theme.of(context).textTheme.headline4),
                        const Expanded(child: NetworkIcon())
                      ],
                    ),
                    const SizedBox(height: 10),
                    SignInForm(
                        userNameCtrl: userNameCtrl, passwordCtrl: passwordCtrl),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: MaterialButton(
                              disabledColor: Colors.grey,
                              elevation: 0,
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: authBloc.state is AuthLoading
                                  ? null
                                  : () {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      final usuario = UsuarioEntity(
                                        userName: userNameCtrl.text,
                                        password: passwordCtrl.text,
                                      );

                                      if (internetCubit.state
                                          is InternetConnected) {
                                        authBloc.add(LogIn(usuario: usuario));
                                      } else if (internetCubit.state
                                          is InternetDisconnected) {
                                        authBloc.add(LogInDB(usuario: usuario));
                                      }
                                    },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: authBloc.state is AuthLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Text(
                                        'Ingresar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
