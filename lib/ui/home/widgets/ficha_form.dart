import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/ficha/ficha_bloc.dart';
import '../../utils/input_decoration.dart';

class FichaForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final userNameCtrl = TextEditingController();

  FichaForm({super.key});

  @override
  Widget build(BuildContext context) {
    final fichaBloc = BlocProvider.of<FichaBloc>(context, listen: true);

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                'Crear Ficha',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: userNameCtrl,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Nombre de usuario',
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icons.person),
              ),
              const SizedBox(height: 30.0),
              MaterialButton(
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: fichaBloc.state is FichaLoading
                      ? null
                      : () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                        },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: fichaBloc.state is FichaLoading
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
            ],
          ),
        ));
  }
}
