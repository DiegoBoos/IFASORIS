import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/ficha/pages/grupo_familiar_page.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart';
import '../../cubits/autoridad_indigena/autoridad_indigena_cubit.dart';
import '../../cubits/cereal_by_dpto/cereal_by_dpto_cubit.dart';
import '../../cubits/costo_desplazamiento/costo_desplazamiento_cubit.dart';
import '../../cubits/curso_vida/curso_vida_cubit.dart';
import '../../cubits/dificultad_acceso_ca/dificultad_acceso_ca_cubit.dart';
import '../../cubits/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_cubit.dart';
import '../../cubits/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_cubit.dart';
import '../../cubits/especie_animal_by_dpto/especie_animal_by_dpto_cubit.dart';
import '../../cubits/estado_via/estado_via_cubit.dart';
import '../../cubits/etnia/etnia_cubit.dart';
import '../../cubits/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_cubit.dart';
import '../../cubits/fruto_by_dpto/fruto_by_dpto_cubit.dart';
import '../../cubits/genero/genero_cubit.dart';
import '../../cubits/grupo_riesgo/grupo_riesgo_cubit.dart';
import '../../cubits/hortaliza_by_dpto/hortaliza_by_dpto_cubit.dart';
import '../../cubits/iluminacion_vivienda/iluminacion_vivienda_cubit.dart';
import '../../cubits/leguminosa_by_dpto/leguminosa_by_dpto_cubit.dart';
import '../../cubits/lengua_maneja/lengua_maneja_cubit.dart';
import '../../cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import '../../cubits/medio_utiliza_ca/medio_utiliza_ca_cubit.dart';
import '../../cubits/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_cubit.dart';
import '../../cubits/nivel_educativo/nivel_educativo_cubit.dart';
import '../../cubits/nombre_lengua_materna/nombre_lengua_materna_cubit.dart';
import '../../cubits/ocupacion/ocupacion_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../cubits/parentesco/parentesco_cubit.dart';
import '../../cubits/piso_vivienda_by_dpto/piso_vivienda_by_dpto_cubit.dart';
import '../../cubits/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_cubit.dart';
import '../../cubits/pueblo_indigena_by_dpto/pueblo_indigena_by_dpto_cubit.dart';
import '../../cubits/regimen/regimen_cubit.dart';
import '../../cubits/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_cubit.dart';
import '../../cubits/techo_vivienda_by_dpto/techo_vivienda_by_dpto_cubit.dart';
import '../../cubits/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_cubit.dart';
import '../../cubits/tiempo_tarda_ca/tiempo_tarda_ca_cubit.dart';
import '../../cubits/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_cubit.dart';
import '../../cubits/tipo_calendario/tipo_calendario_cubit.dart';
import '../../cubits/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_cubit.dart';
import '../../cubits/tipo_documento/tipo_documento_cubit.dart';
import '../../cubits/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_cubit.dart';
import '../../cubits/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_cubit.dart';
import '../../cubits/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_cubit.dart';
import '../../cubits/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_cubit.dart';
import '../../cubits/ventilacion_vivienda/ventilacion_vivienda_cubit.dart';
import '../../cubits/verdura_by_dpto/verdura_by_dpto_cubit.dart';
import '../../cubits/via_acceso/via_acceso_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/acceso_ca_form.dart';
import '../widgets/acceso_medico_form.dart';
import '../widgets/aspectos_tierra.dart';
import '../widgets/datos_ubicacion_form.dart';
import '../widgets/datos_vivienda_form.dart';

class FichaPage extends StatefulWidget {
  const FichaPage({super.key});

  @override
  State<FichaPage> createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  final _formKeyUbicacion = GlobalKey<FormState>();
  final _formKeyVivienda = GlobalKey<FormState>();
  int currentStep = 0;
  bool isCompleted = false;
  double percentage = 0.0;
  int registraAfiliados = 0;

  @override
  void initState() {
    super.initState();

    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    BlocProvider.of<DimUbicacionBloc>(context)
        .add(GetDimUbicacion(afiliado.familiaId!));

    BlocProvider.of<DimViviendaBloc>(context)
        .add(GetDimVivienda(afiliado.familiaId!));

    BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context)
        .add(GetAfiliadosGrupoFamiliar(afiliado.familiaId!));

    getAccesorias();
  }

  getAccesorias() {
    BlocProvider.of<AutoridadIndigenaCubit>(context)
        .getAutoridadesIndigenasDB();
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
    BlocProvider.of<TipoViviendaByDptoCubit>(context)
        .getTiposViviendaByDptoDB();
    BlocProvider.of<TenenciaViviendaByDptoCubit>(context)
        .getTenenciasViviendaByDptoDB();
    BlocProvider.of<PisoViviendaByDptoCubit>(context)
        .getPisosViviendaByDptoDB();
    BlocProvider.of<TechoViviendaByDptoCubit>(context)
        .getTechosViviendaByDptoDB();
    BlocProvider.of<VentilacionViviendaCubit>(context)
        .getVentilacionesViviendaDB();
    BlocProvider.of<IluminacionViviendaCubit>(context)
        .getIluminacionesViviendaDB();
    BlocProvider.of<ServicioPublicoViviendaByDptoCubit>(context)
        .getServiciosPublicosViviendaByDptoDB();
    BlocProvider.of<TratamientoAguaViviendaByDptoCubit>(context)
        .getTratamientosAguaViviendaByDptoDB();
    BlocProvider.of<TipoSanitarioViviendaByDptoCubit>(context)
        .getTiposSanitarioViviendaByDptoDB();
    BlocProvider.of<TipoCombustibleViviendaByDptoCubit>(context)
        .getTiposCombustibleViviendaByDptoDB();
    BlocProvider.of<FactorRiesgoViviendaByDptoCubit>(context)
        .getFactoresRiesgoViviendaByDptoDB();
    BlocProvider.of<PresenciaAnimalViviendaByDptoCubit>(context)
        .getPresenciaAnimalesViviendaDB();
    BlocProvider.of<TuberculoPlatanoByDptoCubit>(context)
        .getTuberculosPlatanosByDptoDB();
    BlocProvider.of<EspecieAnimalByDptoCubit>(context)
        .getEspeciesAnimalesByDptoDB();
    BlocProvider.of<LeguminosaByDptoCubit>(context).getLeguminosasByDptoDB();
    BlocProvider.of<HortalizaByDptoCubit>(context).getHortalizasByDptoDB();
    BlocProvider.of<VerduraByDptoCubit>(context).getVerdurasByDptoDB();
    BlocProvider.of<FrutoByDptoCubit>(context).getFrutosByDptoDB();
    BlocProvider.of<CerealByDptoCubit>(context).getCerealesByDptoDB();
    BlocProvider.of<TipoCalendarioCubit>(context).getTiposCalendarioDB();
    BlocProvider.of<TipoDocumentoCubit>(context).getTiposDocumentoDB();
    BlocProvider.of<GeneroCubit>(context).getGenerosDB();
    BlocProvider.of<CursoVidaCubit>(context).getCursosVidaDB();
    BlocProvider.of<ParentescoCubit>(context).getParentescosDB();
    BlocProvider.of<RegimenCubit>(context).getRegimenesDB();
    BlocProvider.of<NivelEducativoCubit>(context).getNivelesEducativosDB();
    BlocProvider.of<OcupacionCubit>(context).getOcupacionesDB();
    BlocProvider.of<EtniaCubit>(context).getEtniasDB();
    BlocProvider.of<PuebloIndigenaByDptoCubit>(context)
        .getPueblosIndigenasByDptoDB();
    BlocProvider.of<GrupoRiesgoCubit>(context).getGruposRiesgoDB();
    BlocProvider.of<LenguaManejaCubit>(context).getLenguasManejaDB();
    BlocProvider.of<NombreLenguaMaternaCubit>(context)
        .getNombresLenguasMaternaDB();
  }

  @override
  Widget build(BuildContext context) {
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    final dimUbicacionBloc =
        BlocProvider.of<DimUbicacionBloc>(context, listen: true);
    final dimViviendaBloc =
        BlocProvider.of<DimViviendaBloc>(context, listen: true);
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context, listen: true);

    return MultiBlocListener(
        listeners: [
          BlocListener<DimUbicacionBloc, DimUbicacionEntity>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is DimUbicacionSubmissionSuccess) {
                CustomSnackBar.showSnackBar(context,
                    'Datos de ubicación guardados correctamente', Colors.green);

                setState(() {
                  currentStep = 1;
                });
              }
              if (formStatus is DimUbicacionSubmissionFailed) {
                CustomSnackBar.showSnackBar(
                    context, formStatus.message.toString(), Colors.red);
              }
            },
          ),
          BlocListener<DimViviendaBloc, DimViviendaEntity>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is DimViviendaSubmissionSuccess) {
                CustomSnackBar.showSnackBar(context,
                    'Datos de vivienda guardados correctamente', Colors.green);

                setState(() {
                  currentStep = 2;
                });
              }
              if (formStatus is DimViviendaSubmissionFailed) {
                CustomSnackBar.showSnackBar(
                    context, formStatus.message.toString(), Colors.red);
              }
            },
          ),
          BlocListener<AfiliadosGrupoFamiliarBloc, AfiliadosGrupoFamiliarState>(
            listener: (context, state) {
              if (state is GrupoFamiliarSubmissionSuccess) {
                CustomSnackBar.showSnackBar(
                    context,
                    'Datos del grupo familiar guardados correctamente',
                    Colors.green);

                setState(() {
                  isCompleted = true;
                });
              }
              if (state is GrupoFamiliarSubmissionFailed) {
                CustomSnackBar.showSnackBar(
                    context, state.message.toString(), Colors.red);
              }
            },
          ),
          BlocListener<AfiliadosGrupoFamiliarBloc, AfiliadosGrupoFamiliarState>(
              listener: (context, state) {
            if (state is AfiliadosGrupoFamiliarLoaded ||
                state is AfiliadosGrupoFamiliarError) {
              final grupoFamiliarCompleted = state.afiliadosGrupoFamiliar!
                  .where((element) => element.isCompleted == true)
                  .length;
              setState(() {
                percentage = (grupoFamiliarCompleted /
                        state.afiliadosGrupoFamiliar!.length) *
                    100;
              });
            }
          })
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Ficha'),
          ),
          body: isCompleted
              ? buildCompleted()
              : Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme:
                          const ColorScheme.light(primary: Colors.green)),
                  child: Stepper(
                    type: StepperType.horizontal,
                    steps: getSteps(),
                    currentStep: currentStep,
                    onStepContinue: () async {
                      final isLastStep = currentStep == getSteps().length - 1;

                      if (currentStep == 0) {
                        if (_formKeyUbicacion.currentState!.validate()) {
                          _formKeyUbicacion.currentState!.save();

                          dimUbicacionBloc.add(
                              DimUbicacionFamiliaChanged(afiliado.familiaId!));
                          dimUbicacionBloc.add(DimUbicacionSubmitted());
                        }
                      } else if (currentStep == 1) {
                        if (_formKeyVivienda.currentState!.validate()) {
                          _formKeyVivienda.currentState!.save();
                          dimViviendaBloc.add(
                              DimViviendaFamiliaChanged(afiliado.familiaId!));
                          dimViviendaBloc.add(DimViviendaSubmitted());
                        }
                      } else if (isLastStep) {
                        afiliadosGrupoFamiliarBloc.add(
                            SaveAfiliadosGrupoFamiliar(
                                afiliadosGrupoFamiliarBloc
                                        .state.afiliadosGrupoFamiliar ??
                                    []));
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
                            onPressed: !isLastStep ||
                                    (isLastStep && percentage == 100.0) ||
                                    (isLastStep &&
                                        percentage == 0.0 &&
                                        registraAfiliados == 1)
                                ? details.onStepContinue
                                : null,
                            child: Text(isLastStep ? 'Finalizar' : 'Siguiente'),
                          )),
                          const SizedBox(
                            width: 12,
                          ),
                        ]),
                      );
                    },
                  ),
                ),
        ));
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Ubicación'),
          content: BlocBuilder<DimUbicacionBloc, DimUbicacionEntity>(
            builder: (context, state) {
              if (state.formStatus is DimUbicacionFormEmpty) {
                return Form(
                    key: _formKeyUbicacion,
                    child: Column(
                      children: const [
                        DatosUbicacionForm(),
                        AccesoCAForm(),
                        AccesoMedicoForm(),
                        AspectosTierraForm(),
                      ],
                    ));
              } else if (state.formStatus is DimUbicacionFormLoaded ||
                  state.formStatus is DimUbicacionSubmissionSuccess) {
                return Form(
                    key: _formKeyUbicacion,
                    child: Column(
                      children: [
                        DatosUbicacionForm(dimUbicacion: state),
                        AccesoCAForm(dimUbicacion: state),
                        AccesoMedicoForm(dimUbicacion: state),
                        AspectosTierraForm(dimUbicacion: state),
                      ],
                    ));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Vivienda'),
          content: BlocBuilder<DimViviendaBloc, DimViviendaEntity>(
            builder: (context, state) {
              if (state.formStatus is DimViviendaFormEmpty) {
                return Form(
                    key: _formKeyVivienda, child: const DatosViviendaForm());
              } else if (state.formStatus is DimViviendaFormLoaded ||
                  state.formStatus is DimViviendaSubmissionSuccess) {
                return Form(
                    key: _formKeyVivienda,
                    child: DatosViviendaForm(
                      dimVivienda: state,
                    ));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text('Grupo Familiar'),
          content: BlocConsumer<AfiliadosGrupoFamiliarBloc,
              AfiliadosGrupoFamiliarState>(
            listener: (context, state) {
              if (state is AfiliadosGrupoFamiliarLoaded ||
                  state is AfiliadosGrupoFamiliarError) {
                final grupoFamiliarCompleted = state.afiliadosGrupoFamiliar!
                    .where((element) => element.isCompleted == true)
                    .length;
                setState(() {
                  percentage = (grupoFamiliarCompleted /
                          state.afiliadosGrupoFamiliar!.length) *
                      100;
                });
              }
            },
            builder: (context, state) {
              if (state is AfiliadosGrupoFamiliarLoaded ||
                  state is AfiliadosGrupoFamiliarError) {
                return Column(
                  children: [
                    const Text('Tiene miembros en la familia para registrar'),
                    RadioListTile(
                      title: const Text('Si'),
                      value: 0,
                      groupValue: registraAfiliados,
                      onChanged: (int? value) {
                        setState(() {
                          registraAfiliados = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('No'),
                      value: 1,
                      groupValue: registraAfiliados,
                      onChanged: (int? value) {
                        setState(() {
                          registraAfiliados = value!;
                        });
                      },
                    ),
                    GrupoFamiliarPage(
                      percentage: percentage,
                      registraAfiliados: registraAfiliados,
                    ),
                  ],
                );
              } else if (state is AfiliadosGrupoFamiliarEmpty) {
                return Column(
                  children: [
                    const Text('Tiene miembros en la familia para registrar'),
                    RadioListTile(
                      title: const Text('Si'),
                      value: 0,
                      groupValue: registraAfiliados,
                      onChanged: (int? value) {
                        setState(() {
                          registraAfiliados = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('No'),
                      value: 1,
                      groupValue: registraAfiliados,
                      onChanged: (int? value) {
                        setState(() {
                          registraAfiliados = value!;
                        });
                      },
                    ),
                    GrupoFamiliarPage(
                      percentage: percentage,
                      registraAfiliados: registraAfiliados,
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        )
      ];

  Widget buildCompleted() {
    return AlertDialog(
      title: const Text('Ficha guardada'),
      content: const Text('Registro completado.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
