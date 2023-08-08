import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/atencion_salud_entity.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../blocs/encuesta/encuesta_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/atenciones_en_salud_form.dart';
import '../widgets/progress_bar.dart';

class AtencionSaludPage extends StatefulWidget {
  const AtencionSaludPage({super.key});

  @override
  State<AtencionSaludPage> createState() => _AtencionSaludPageState();
}

class _AtencionSaludPageState extends State<AtencionSaludPage> {
  int afiliadoPageIndex = 0;
  final afiliadoPageController = PageController(initialPage: 0);
  late List<GlobalKey<FormState>> formKeys;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);

    formKeys = List.generate(
      encuestaBloc.state.afiliados.length,
      (_) => GlobalKey<FormState>(),
    );
  }

  void _submitForm() {
    final currentForm = formKeys[afiliadoPageIndex].currentState;
    if (currentForm != null && currentForm.validate()) {
      currentForm.save();

      final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);
      final afiliados = encuestaBloc.state.afiliados;

      final atencionSaludBloc = BlocProvider.of<AtencionSaludBloc>(context);

      atencionSaludBloc
          .add(AfiliadoChanged(afiliados[afiliadoPageIndex].afiliadoId!));
      atencionSaludBloc
          .add(FamiliaChanged(afiliados[afiliadoPageIndex].familiaId!));
      atencionSaludBloc.add(AtencionSaludSubmitted());
    }
  }

  @override
  Widget build(BuildContext context) {
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);
    final atencionSaludBloc = BlocProvider.of<AtencionSaludBloc>(context);
    return WillPopScope(
        onWillPop: () async {
          CustomSnackBar.showCustomDialog(
              context,
              'Está seguro que desea salir',
              'Se perderán los datos no guardados.', () {
            Navigator.popUntil(context, ModalRoute.withName('home'));
            return;
          }, true);
          return false;
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<AtencionSaludBloc, AtencionSaludEntity>(
              listener: (context, state) {
                final formStatus = state.formStatus;
                if (formStatus is AtencionSaludSubmissionSuccess) {
                  CustomSnackBar.showSnackBar(
                      context,
                      'Datos de atenciones en salud guardados correctamente',
                      Colors.green);

                  atencionSaludBloc.add(AtencionSaludInit());

                  if (afiliadoPageIndex <
                      encuestaBloc.state.afiliados.length - 1) {
                    afiliadoPageController.animateToPage(
                      afiliadoPageIndex + 1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInExpo,
                    );
                  } else {
                    setState(() {
                      _isCompleted = true;
                    });
                  }
                }

                if (formStatus is AtencionSaludSubmissionFailed) {
                  CustomSnackBar.showSnackBar(
                      context, formStatus.message, Colors.red);

                  atencionSaludBloc.add(AtencionSaludInit());
                }
              },
            )
          ],
          child: Scaffold(
            appBar: AppBar(title: const Text('Atención en salud')),
            body: _isCompleted
                ? buildCompleted()
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        /*  const ProgressBar(), */
                        Expanded(
                          child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: afiliadoPageController,
                            itemCount: encuestaBloc.state.afiliados.length,
                            onPageChanged: (index) {
                              setState(() {
                                afiliadoPageIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final currentAfiliado =
                                  encuestaBloc.state.afiliados[index];

                              BlocProvider.of<AtencionSaludBloc>(context).add(
                                  GetAtencionSalud(
                                      currentAfiliado.afiliadoId!));

                              return BlocBuilder<AtencionSaludBloc,
                                  AtencionSaludEntity>(
                                builder: (context, state) {
                                  if (state.formStatus
                                      is AtencionSaludFormEmpty) {
                                    return Form(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      key: formKeys[index],
                                      child: AtencionSaludForm(
                                        currentAfiliado: currentAfiliado,
                                      ),
                                    );
                                  } else if (state.formStatus
                                          is AtencionSaludFormLoaded ||
                                      state.formStatus
                                          is AtencionSaludSubmissionSuccess) {
                                    return Form(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        key: formKeys[index],
                                        child: AtencionSaludForm(
                                            currentAfiliado: currentAfiliado,
                                            atencionSalud: state));
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }

  Widget buildCompleted() {
    return AlertDialog(
      title: const Text('Ficha guardada'),
      content: const Text('Registro completado.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
