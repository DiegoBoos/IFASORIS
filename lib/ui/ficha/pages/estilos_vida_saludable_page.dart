import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/estilo_vida_saludable_entity.dart';
import '../../blocs/encuesta/encuesta_bloc.dart';
import '../../blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/estilos_vida_saludable_form.dart';

class EstilosVidaSaludablePage extends StatefulWidget {
  const EstilosVidaSaludablePage({super.key});

  @override
  State<EstilosVidaSaludablePage> createState() =>
      _EstilosVidaSaludablePageState();
}

class _EstilosVidaSaludablePageState extends State<EstilosVidaSaludablePage> {
  int afiliadoPageIndex = 0;
  final afiliadoPageController = PageController(initialPage: 0);
  late List<GlobalKey<FormState>> formKeys;

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

      final estiloVidaSaludableBloc =
          BlocProvider.of<EstiloVidaSaludableBloc>(context);

      estiloVidaSaludableBloc
          .add(AfiliadoChanged(afiliados[afiliadoPageIndex].afiliadoId!));
      estiloVidaSaludableBloc
          .add(FamiliaChanged(afiliados[afiliadoPageIndex].familiaId!));
      estiloVidaSaludableBloc.add(EstiloVidaSaludableSubmitted());
    }
  }

  @override
  Widget build(BuildContext context) {
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);
    final estiloVidaSaludableBloc =
        BlocProvider.of<EstiloVidaSaludableBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        CustomSnackBar.showCustomDialog(context, 'Está seguro que desea salir',
            'Se perderán los datos no guardados.', () {
          Navigator.popUntil(context, ModalRoute.withName('home'));
          return;
        });
        return false;
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<EstiloVidaSaludableBloc, EstiloVidaSaludableEntity>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is EstiloVidaSaludableSubmissionSuccess) {
                CustomSnackBar.showSnackBar(
                    context,
                    'Datos de estilo de vida saludable guardados correctamente',
                    Colors.green);

                if (afiliadoPageIndex <
                    encuestaBloc.state.afiliados.length - 1) {
                  afiliadoPageController.animateToPage(
                    afiliadoPageIndex + 1,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInExpo,
                  );
                } else {
                  Navigator.pushReplacementNamed(
                      context, 'cuidado-salud-cond-riesgo');
                }
              }

              if (formStatus is EstiloVidaSaludableSubmissionFailed) {
                CustomSnackBar.showSnackBar(
                    context, formStatus.message, Colors.red);

                estiloVidaSaludableBloc.add(EstiloVidaSaludableInit());
              }
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(title: const Text('Estilos de vida saludable')),
          body: Padding(
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

                      BlocProvider.of<EstiloVidaSaludableBloc>(context).add(
                          GetEstiloVidaSaludable(currentAfiliado.afiliadoId!));

                      return BlocBuilder<EstiloVidaSaludableBloc,
                          EstiloVidaSaludableEntity>(
                        builder: (context, state) {
                          if (state.formStatus
                              is EstiloVidaSaludableFormEmpty) {
                            return Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: formKeys[index],
                              child: EstilosVidaSaludableForm(
                                currentAfiliado: currentAfiliado,
                              ),
                            );
                          } else if (state.formStatus
                              is EstiloVidaSaludableFormLoaded) {
                            return Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                key: formKeys[index],
                                child: EstilosVidaSaludableForm(
                                    currentAfiliado: currentAfiliado,
                                    estiloVidaSaludable: state));
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
      ),
    );
  }
}
