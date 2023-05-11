import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/dim_ubicacion/dim_ubicacion_exports.dart';
import 'package:ifasoris/ui/cubits/estado_via/estado_via_cubit.dart';
import 'package:ifasoris/ui/cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import 'package:ifasoris/ui/cubits/opcion_si_no/opcion_si_no_cubit.dart';
import 'package:ifasoris/ui/cubits/via_acceso/via_acceso_cubit.dart';

import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../cubits/costo_desplazamiento/costo_desplazamiento_cubit.dart';
import '../../cubits/dificultad_acceso_ca/dificultad_acceso_ca_cubit.dart';
import '../../cubits/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_cubit.dart';
import '../../cubits/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_cubit.dart';
import '../../cubits/medio_utiliza_ca/medio_utiliza_ca_cubit.dart';
import '../../cubits/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_cubit.dart';
import '../../cubits/tiempo_tarda_ca/tiempo_tarda_ca_cubit.dart';
import '../../cubits/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_cubit.dart';
import '../widgets/acceso_ca_form.dart';
import '../widgets/acceso_medico_form.dart';
import '../widgets/datos_ubicacion_form.dart';
import '../widgets/datos_vivienda_form.dart';
import '../widgets/grupo_familiar_form.dart';

class FichaPage extends StatefulWidget {
  const FichaPage({super.key});

  @override
  State<FichaPage> createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  final _formKeyUbicacion = GlobalKey<FormState>();
  final _formKeyVivienda = GlobalKey<FormState>();
  final _formKeyGrupoFamiliar = GlobalKey<FormState>();
  int currentStep = 0;
  bool isCompleted = false;
  DimUbicacionEntity? dimUbicacion;

  @override
  void initState() {
    super.initState();
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;
    BlocProvider.of<DimUbicacionCubit>(context)
        .getDimUbicacion(afiliado.familiaId!);

    getAccesorias();
  }

  getAccesorias() {
    BlocProvider.of<ViaAccesoCubit>(context).getViasAccesoDB();
    BlocProvider.of<EstadoViaCubit>(context).getEstadosVias();
    BlocProvider.of<MedioComunicacionCubit>(context).getMediosComunicacionDB();
    BlocProvider.of<TiempoTardaCACubit>(context).getTiemposTardaCADB();
    BlocProvider.of<MedioUtilizaCACubit>(context).getMediosUtilizaCA();
    BlocProvider.of<DificultadAccesoCACubit>(context).getDificultadesAccesoCA();
    BlocProvider.of<CostoDesplazamientoCubit>(context)
        .getCostosDesplazamientoDB();
    BlocProvider.of<MedioUtilizaMedTradicionalByDptoCubit>(context)
        .getMediosUtilizaMedTradicionalByDpto();
    BlocProvider.of<EspecialidadMedTradicionalByDptoCubit>(context)
        .getEspecialidadesMedTradicionalByDptoDB();
    BlocProvider.of<TiempoTardaMedTradicionalCubit>(context)
        .getTiemposTardaMedTradicionalDB();
    BlocProvider.of<DificultadAccesoMedTradicionalByDptoCubit>(context)
        .getDificultadesAccesoMedTradicionalByDpto();
    BlocProvider.of<OpcionSiNoCubit>(context).getOpcionesSiNoDB();
  }

  @override
  Widget build(BuildContext context) {
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    final dimUbicacionCubit = BlocProvider.of<DimUbicacionCubit>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación'),
      ),
      body: isCompleted
          ? buildCompleted()
          : Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: Colors.green)),
              child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
                currentStep: currentStep,
                onStepContinue: () async {
                  final isLastStep = currentStep == getSteps().length - 1;

                  if (currentStep == 0) {
                    if (_formKeyUbicacion.currentState!.validate()) {
                      _formKeyUbicacion.currentState!.save();

                      dimUbicacionCubit.changeFamiliaId(afiliado.familiaId!);

                      dimUbicacionCubit.saveDimUbicacionDB(
                          dimUbicacionCubit.state.dimUbicacion,
                          afiliado.familiaId!);
                    } else if (currentStep == 1) {
                      print('middle step');
                    } else if (isLastStep) {
                      print('last step');
                    }
                  } else {
                    setState(() => currentStep += 1);
                  }
                },
                onStepCancel: currentStep == 0
                    ? null
                    : () => setState(() => currentStep -= 1),
                controlsBuilder: (context, details) {
                  final isLastStep = currentStep == getSteps().length - 1;
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(isLastStep ? 'Finalizar' : 'Siguiente'),
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      if (currentStep != 0)
                        Expanded(
                            child: ElevatedButton(
                                onPressed: details.onStepCancel,
                                child: const Text('Anterior')))
                    ]),
                  );
                },
              ),
            ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Ubicación'),
          content: Form(
              key: _formKeyUbicacion,
              child: Column(
                children: const [
                  DatosUbicacionForm(),
                  AccesoCAForm(),
                  AccesoMedicoForm()
                ],
              )),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text('Vivienda'),
            content:
                Form(key: _formKeyVivienda, child: const DatosViviendaForm())),
        Step(
            isActive: currentStep >= 2,
            title: const Text('Grupo Familiar'),
            content: const GrupoFamiliar())
      ];

  Widget buildCompleted() {
    return Container();
  }
}
