import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../domain/entities/usuario.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../cubits/internet/internet_cubit.dart';
import '../../utils/device_info.dart';
import '../../utils/input_decoration.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  /* final userNameCtrl = TextEditingController(text: 'sirispruebas');
  final passwordCtrl = TextEditingController(text: 'Siris*2024'); */
  final emailCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool eyeToggle = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    final internetCubit = BlocProvider.of<InternetCubit>(context);

    login() async {
      if (!formKey.currentState!.validate()) {
        return;
      }

      final email = emailCtrl.text;
      final username = usernameCtrl.text;
      final password = passwordCtrl.text;
      try {
        await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );

        await DeviceInfo.infoDispositivo().then((datosEquipo) {
          if (datosEquipo != null && datosEquipo.idEquipo != null) {
            final usuario = UsuarioEntity(
              userName: username,
              password: password,
              deviceId: datosEquipo.idEquipo,
            );

            if (internetCubit.state is InternetConnected) {
              authBloc.add(LogIn(usuario: usuario));
            } else if (internetCubit.state is InternetDisconnected) {
              authBloc.add(LogInDB(usuario: usuario));
            }
          }
        });
      } on AuthException catch (error) {
        context.showErrorSnackBar(message: error.message);
      } catch (error) {
        context.showErrorSnackBar(message: 'Excepción no controlada');
      }
    }

    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: emailCtrl,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Ingrese el email',
                    labelText: 'Email',
                    prefixIcon: Icons.email),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Requerido*';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: usernameCtrl,
                autocorrect: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Ingrese el nombre de usuario',
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Requerido*';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: passwordCtrl,
                autocorrect: false,
                obscureText: eyeToggle,
                decoration: CustomInputDecoration.inputDecoration(
                  hintText: '******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: IconButton(
                      onPressed: () => setState(() => eyeToggle = !eyeToggle),
                      icon: eyeToggle
                          ? const Icon(
                              Icons.remove_red_eye,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.solidEyeSlash,
                              size: 18,
                            )),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Requerido*';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              MaterialButton(
                  minWidth: double.infinity,
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed:
                      authBloc.state is AuthLoading ? null : () => login(),
                  child: authBloc.state is AuthLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Ingresar',
                          style: TextStyle(color: Colors.white),
                        )),
            ],
          ),
        ));
  }
}
