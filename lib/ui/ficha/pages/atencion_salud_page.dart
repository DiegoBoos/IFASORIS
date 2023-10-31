import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/cubits/especialidad_med_tradicional/especialidad_med_tradicional_cubit.dart';
import 'package:ifasoris/ui/cubits/opcion_si_no/opcion_si_no_cubit.dart';

import '../../../domain/entities/atencion_salud_entity.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart' as gf;
import '../../cubits/enfermedad_acude/enfermedad_acude_cubit.dart';
import '../../cubits/enfermedad_tradicional/enfermedad_tradicional_cubit.dart';
import '../../cubits/enfermedad_tratamiento/enfermedad_tratamiento_cubit.dart';
import '../../cubits/lugar_atencion_medico/lugar_atencion_medico_cubit.dart';
import '../../cubits/lugar_planta_medicinal/lugar_planta_medicinal_cubit.dart';
import '../../cubits/planta_medicinal/planta_medicinal_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/atencion_salud_form.dart';

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
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);

    formKeys = List.generate(
      afiliadosGrupoFamiliarBloc.state.afiliadosGrupoFamiliar!.length,
      (_) => GlobalKey<FormState>(),
    );

    getAccesoriasAtencionSalud();
  }

  getAccesoriasAtencionSalud() {
    BlocProvider.of<EnfermedadAcudeCubit>(context).getEnfermedadAcudeDB();
    BlocProvider.of<OpcionSiNoCubit>(context).getOpcionesSiNoDB();
    BlocProvider.of<EspecialidadMedTradicionalCubit>(context)
        .getEspecialidadesMedTradicionalDB();
    BlocProvider.of<EnfermedadTradicionalCubit>(context)
        .getEnfermedadTradicionalDB();
    BlocProvider.of<LugarAtencionMedicoCubit>(context)
        .getLugaresAtencionMedicoDB();
    BlocProvider.of<EnfermedadTratamientoCubit>(context)
        .getEnfermedadTratamientoDB();
    BlocProvider.of<LugarPlantaMedicinalCubit>(context)
        .getLugarPlantaMedicinalDB();
    BlocProvider.of<PlantaMedicinalCubit>(context).getPlantasMedicinalesDB();
  }

  void _submitForm() {
    final currentForm = formKeys[afiliadoPageIndex].currentState;
    if (currentForm != null && currentForm.validate()) {
      currentForm.save();

      final afiliadosGrupoFamiliarBloc =
          BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);
      final afiliados =
          afiliadosGrupoFamiliarBloc.state.afiliadosGrupoFamiliar!;

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
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);
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
                      afiliadosGrupoFamiliarBloc
                              .state.afiliadosGrupoFamiliar!.length -
                          1) {
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
            ),
          ],
          child: Scaffold(
            appBar: AppBar(title: const Text('Atención en salud')),
            body: _isCompleted
                ? buildCompleted()
                : Padding(
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

                              BlocProvider.of<AtencionSaludBloc>(context).add(
                                  GetAtencionSalud(
                                      currentAfiliado.afiliadoId!));

                              return BlocBuilder<AtencionSaludBloc,
                                  AtencionSaludEntity>(
                                builder: (context, state) {
                                  if (state.formStatus
                                          is AtencionSaludFormInitial ||
                                      state.formStatus
                                          is AtencionSaludFormLoaded) {
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
                        BlocBuilder<AtencionSaludBloc, AtencionSaludEntity>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state is AtencionSaludFormLoading
                                    ? null
                                    : _submitForm,
                                child: const Text('Siguiente'),
                              ),
                            );
                          },
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
          onPressed: () async {
            final grupoFamiliarBloc =
                BlocProvider.of<gf.GrupoFamiliarBloc>(context);
            final afiliadoPrefsBloc =
                BlocProvider.of<AfiliadoPrefsBloc>(context);
            final afiliado = afiliadoPrefsBloc.state.afiliado!;

            await grupoFamiliarBloc
                .completeGrupoFamiliar(afiliado.familiaId!)
                .then((value) {
              Navigator.pushReplacementNamed(context, 'home');
            });
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
