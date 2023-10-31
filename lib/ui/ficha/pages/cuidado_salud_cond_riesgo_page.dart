import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/cuidado_salud_cond_riesgo_form.dart';

class CuidadoSaludCondRiesgoPage extends StatefulWidget {
  const CuidadoSaludCondRiesgoPage({super.key});

  @override
  State<CuidadoSaludCondRiesgoPage> createState() =>
      _CuidadoSaludCondRiesgoPageState();
}

class _CuidadoSaludCondRiesgoPageState
    extends State<CuidadoSaludCondRiesgoPage> {
  int afiliadoPageIndex = 0;
  final afiliadoPageController = PageController(initialPage: 0);
  late List<GlobalKey<FormState>> formKeys;

  @override
  void initState() {
    super.initState();
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);

    formKeys = List.generate(
      afiliadosGrupoFamiliarBloc.state.afiliadosGrupoFamiliar!.length,
      (_) => GlobalKey<FormState>(),
    );
  }

  void _submitForm() {
    final currentForm = formKeys[afiliadoPageIndex].currentState;
    if (currentForm != null && currentForm.validate()) {
      currentForm.save();

      final afiliadosGrupoFamiliarBloc =
          BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);
      final afiliados =
          afiliadosGrupoFamiliarBloc.state.afiliadosGrupoFamiliar!;

      final cuidadoSaludCondRiesgoBloc =
          BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);

      cuidadoSaludCondRiesgoBloc
          .add(AfiliadoChanged(afiliados[afiliadoPageIndex].afiliadoId!));

      cuidadoSaludCondRiesgoBloc
          .add(FamiliaChanged(afiliados[afiliadoPageIndex].familiaId!));

      cuidadoSaludCondRiesgoBloc.add(CuidadoSaludCondRiesgoSubmitted());
    }
  }

  @override
  Widget build(BuildContext context) {
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);
    final cuidadoSaludCondRiesgoBloc =
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);
    return WillPopScope(
        onWillPop: () async {
          CustomSnackBar.showCustomDialog(
              context,
              'Está seguro que desea salir',
              'Se perderán los datos no guardados.', () {
            Navigator.popUntil(context, ModalRoute.withName('home'));
            return;
          });
          return false;
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<CuidadoSaludCondRiesgoBloc,
                CuidadoSaludCondRiesgoEntity>(
              listener: (context, state) {
                final formStatus = state.formStatus;
                if (formStatus is CuidadoSaludCondRiesgoSubmissionSuccess) {
                  cuidadoSaludCondRiesgoBloc.add(CuidadoSaludCondRiesgoInit());

                  if (afiliadoPageIndex <
                      afiliadosGrupoFamiliarBloc
                              .state.afiliadosGrupoFamiliar!.length -
                          1) {
                    afiliadoPageController.animateToPage(
                      afiliadoPageIndex + 1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInExpo,
                    );
                  } else {
                    Navigator.pushReplacementNamed(
                        context, 'dimension-sociocultural-pueblos-indigenas');
                  }
                }

                if (formStatus is CuidadoSaludCondRiesgoSubmissionFailed) {
                  CustomSnackBar.showSnackBar(
                      context, formStatus.message, Colors.red);

                  cuidadoSaludCondRiesgoBloc.add(CuidadoSaludCondRiesgoInit());
                }
              },
            )
          ],
          child: Scaffold(
            appBar:
                AppBar(title: const Text('Cuidado Salud Condiciones Riesgo')),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: afiliadoPageController,
                      itemCount: afiliadosGrupoFamiliarBloc
                          .state.afiliadosGrupoFamiliar!.length,
                      onPageChanged: (index) {
                        setState(() {
                          afiliadoPageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final currentAfiliado = afiliadosGrupoFamiliarBloc
                            .state.afiliadosGrupoFamiliar![index];

                        final cuidadoSaludCondRiesgoBloc =
                            BlocProvider.of<CuidadoSaludCondRiesgoBloc>(
                                context);

                        cuidadoSaludCondRiesgoBloc.add(
                            GetCuidadoSaludCondRiesgo(
                                currentAfiliado.afiliadoId!));

                        return BlocBuilder<CuidadoSaludCondRiesgoBloc,
                            CuidadoSaludCondRiesgoEntity>(
                          builder: (context, state) {
                            if (state.formStatus
                                is CuidadoSaludCondRiesgoFormEmpty) {
                              return Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                key: formKeys[index],
                                child: CuidadoSaludCondRiesgoForm(
                                  currentAfiliado: currentAfiliado,
                                ),
                              );
                            } else if (state.formStatus
                                    is CuidadoSaludCondRiesgoFormLoaded ||
                                state.formStatus
                                    is CuidadoSaludCondRiesgoSubmissionSuccess) {
                              return Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  key: formKeys[index],
                                  child: CuidadoSaludCondRiesgoForm(
                                    currentAfiliado: currentAfiliado,
                                    cuidadoSaludCondRiesgo: state,
                                  ));
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
}
