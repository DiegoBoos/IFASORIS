import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/dimension_sociocultural_pueblos_indigenas_form.dart';

class DimensionSocioCulturalPueblosIndigenasPage extends StatefulWidget {
  const DimensionSocioCulturalPueblosIndigenasPage({super.key});

  @override
  State<DimensionSocioCulturalPueblosIndigenasPage> createState() =>
      _DimensionSocioCulturalPueblosIndigenasPageState();
}

class _DimensionSocioCulturalPueblosIndigenasPageState
    extends State<DimensionSocioCulturalPueblosIndigenasPage> {
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

      final dimensionSocioCulturalPueblosIndigenasBloc =
          BlocProvider.of<DimensionSocioCulturalPueblosIndigenasBloc>(context);

      dimensionSocioCulturalPueblosIndigenasBloc
          .add(AfiliadoChanged(afiliados[afiliadoPageIndex].afiliadoId!));
      dimensionSocioCulturalPueblosIndigenasBloc
          .add(FamiliaChanged(afiliados[afiliadoPageIndex].familiaId!));
      dimensionSocioCulturalPueblosIndigenasBloc
          .add(DimensionSocioCulturalPueblosIndigenasSubmitted());
    }
  }

  @override
  Widget build(BuildContext context) {
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);
    final dimensionSocioCulturalPueblosIndigenasBloc =
        BlocProvider.of<DimensionSocioCulturalPueblosIndigenasBloc>(context);
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
            BlocListener<DimensionSocioCulturalPueblosIndigenasBloc,
                DimensionSocioCulturalPueblosIndigenasEntity>(
              listener: (context, state) {
                final formStatus = state.formStatus;
                if (formStatus
                    is DimensionSocioCulturalPueblosIndigenasSubmissionSuccess) {
                  CustomSnackBar.showSnackBar(
                      context,
                      'Datos de dimensión sociocultural pueblos indígenas guardados correctamente',
                      Colors.green);

                  dimensionSocioCulturalPueblosIndigenasBloc
                      .add(DimensionSocioCulturalPueblosIndigenasInit());

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
                        context, 'atenciones-en-salud');
                  }
                }

                if (formStatus
                    is DimensionSocioCulturalPueblosIndigenasSubmissionFailed) {
                  CustomSnackBar.showSnackBar(
                      context, formStatus.message, Colors.red);

                  dimensionSocioCulturalPueblosIndigenasBloc
                      .add(DimensionSocioCulturalPueblosIndigenasInit());
                }
              },
            )
          ],
          child: Scaffold(
            appBar: AppBar(
                title: const Text('Dimensión SocioCultural Pueblos Indígenas')),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  /*   const ProgressBar(), */
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

                        BlocProvider.of<
                                    DimensionSocioCulturalPueblosIndigenasBloc>(
                                context)
                            .add(GetDimensionSocioCulturalPueblosIndigenas(
                                currentAfiliado.afiliadoId!));

                        return BlocBuilder<
                            DimensionSocioCulturalPueblosIndigenasBloc,
                            DimensionSocioCulturalPueblosIndigenasEntity>(
                          builder: (context, state) {
                            if (state.formStatus
                                is DimensionSocioCulturalPueblosIndigenasFormEmpty) {
                              return Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                key: formKeys[index],
                                child:
                                    DimensionSocioCulturalPueblosIndigenasForm(
                                  currentAfiliado: currentAfiliado,
                                ),
                              );
                            } else if (state.formStatus
                                    is DimensionSocioCulturalPueblosIndigenasFormLoaded ||
                                state.formStatus
                                    is DimensionSocioCulturalPueblosIndigenasSubmissionSuccess) {
                              return Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  key: formKeys[index],
                                  child:
                                      DimensionSocioCulturalPueblosIndigenasForm(
                                          currentAfiliado: currentAfiliado,
                                          dimensionSocioCulturalPueblosIndigenas:
                                              state));
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
