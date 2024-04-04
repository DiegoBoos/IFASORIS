import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/input_decoration.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
    required this.userNameCtrl,
    required this.passwordCtrl,
  });

  final TextEditingController userNameCtrl;
  final TextEditingController passwordCtrl;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool eyeToggle = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        TextFormField(
          controller: widget.userNameCtrl,
          autocorrect: false,
          decoration: CustomInputDecoration.inputDecoration(
              hintText: 'Nombre de usuario',
              labelText: 'Nombre de usuario',
              prefixIcon: Icons.alternate_email_sharp),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingrese el nombre de usuario';
            }
            return null;
          },
        ),
        const SizedBox(height: 30.0),
        TextFormField(
          controller: widget.passwordCtrl,
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
              return 'Ingrese la contraseña';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
