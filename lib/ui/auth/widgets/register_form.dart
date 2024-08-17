import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifasoris/core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../domain/entities/usuario.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../utils/device_info.dart';
import '../../utils/input_decoration.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController(text: 'siris837000638@gmail.com');
  final userNameCtrl = TextEditingController(text: 'sirispruebas');
  final passwordCtrl = TextEditingController(text: 'Siris*2024');

  bool eyeToggle = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    userNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);

    register() async {
      if (!formKey.currentState!.validate()) {
        return;
      }

      final email = emailCtrl.text.trim();
      final username = userNameCtrl.text.trim();
      final password = passwordCtrl.text.trim();

      try {
        final datosEquipo = await DeviceInfo.infoDispositivo();

        if (datosEquipo != null && datosEquipo.idEquipo != null) {
          final usuario = UsuarioEntity(
            email: email,
            userName: username,
            password: password,
            deviceId: datosEquipo.idEquipo,
          );

          authBloc.add(Register(usuario: usuario));
        }
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
                controller: userNameCtrl,
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
                      authBloc.state is AuthLoading ? null : () => register(),
                  child: authBloc.state is AuthLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.white),
                        )),
            ],
          ),
        ));
  }
}
