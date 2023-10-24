import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../blocs/encuesta/encuesta_bloc.dart';
import '../../cubits/actividad_fisica/actividad_fisica_cubit.dart';
import '../../cubits/alimentacion/alimentacion_cubit.dart';
import '../../cubits/autoridad_indigena/autoridad_indigena_cubit.dart';
import '../../cubits/cereal/cereal_cubit.dart';
import '../../cubits/cigarrillo_dia/cigarrillo_dia_cubit.dart';
import '../../cubits/condicion_nutricional/condicion_nutricional_cubit.dart';
import '../../cubits/conducta_seguir/conducta_seguir_cubit.dart';
import '../../cubits/consumo_alcohol/consumo_alcohol_cubit.dart';
import '../../cubits/costo_desplazamiento/costo_desplazamiento_cubit.dart';
import '../../cubits/costumbre_practica/costumbre_practica_cubit.dart';
import '../../cubits/cuarto_vivienda/cuarto_vivienda_cubit.dart';
import '../../cubits/curso_vida/curso_vida_cubit.dart';
import '../../cubits/dificultad_acceso_ca/dificultad_acceso_ca_cubit.dart';
import '../../cubits/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_cubit.dart';
import '../../cubits/enfermedad_acude/enfermedad_acude_cubit.dart';
import '../../cubits/enfermedad_tradicional/enfermedad_tradicional_cubit.dart';
import '../../cubits/enfermedad_tratamiento/enfermedad_tratamiento_cubit.dart';
import '../../cubits/especialidad_med_tradicional/especialidad_med_tradicional_cubit.dart';
import '../../cubits/especie_animal/especie_animal_cubit.dart';
import '../../cubits/esquema_vacunacion/esquema_vacunacion_cubit.dart';
import '../../cubits/estado_via/estado_via_cubit.dart';
import '../../cubits/etnia/etnia_cubit.dart';
import '../../cubits/evento_costumbre_participa/evento_costumbre_participa_cubit.dart';
import '../../cubits/factor_riesgo_vivienda/factor_riesgo_vivienda_cubit.dart';
import '../../cubits/fruto/fruto_cubit.dart';
import '../../cubits/genero/genero_cubit.dart';
import '../../cubits/grupo_riesgo/grupo_riesgo_cubit.dart';
import '../../cubits/hortaliza/hortaliza_cubit.dart';
import '../../cubits/iluminacion_vivienda/iluminacion_vivienda_cubit.dart';
import '../../cubits/leguminosa/leguminosa_cubit.dart';
import '../../cubits/lengua_maneja/lengua_maneja_cubit.dart';
import '../../cubits/lugar_atencion_medico/lugar_atencion_medico_cubit.dart';
import '../../cubits/lugar_planta_medicinal/lugar_planta_medicinal_cubit.dart';
import '../../cubits/lugar_vacunacion/lugar_vacunacion_cubit.dart';
import '../../cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import '../../cubits/medio_utiliza_ca/medio_utiliza_ca_cubit.dart';
import '../../cubits/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_cubit.dart';
import '../../cubits/metodo_planificacion/metodo_planificacion_cubit.dart';
import '../../cubits/nivel_educativo/nivel_educativo_cubit.dart';
import '../../cubits/nombre_enfermedad/nombre_enfermedad_cubit.dart';
import '../../cubits/nombre_lengua_materna/nombre_lengua_materna_cubit.dart';
import '../../cubits/ocupacion/ocupacion_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../cubits/parentesco/parentesco_cubit.dart';
import '../../cubits/piso_vivienda/piso_vivienda_cubit.dart';
import '../../cubits/planta_medicinal/planta_medicinal_cubit.dart';
import '../../cubits/presencia_animal_vivienda/presencia_animal_vivienda_cubit.dart';
import '../../cubits/pueblo_indigena/pueblo_indigena_cubit.dart';
import '../../cubits/regimen/regimen_cubit.dart';
import '../../cubits/religion_profesa/religion_profesa_cubit.dart';
import '../../cubits/resguardo/resguardo_cubit.dart';
import '../../cubits/sancion_justicia/sancion_justicia_cubit.dart';
import '../../cubits/seguimiento_enfermedad/seguimiento_enfermedad_cubit.dart';
import '../../cubits/servicio_publico_vivienda/servicio_publico_vivienda_cubit.dart';
import '../../cubits/servicio_solicitado/servicio_solicitado_cubit.dart';
import '../../cubits/techo_vivienda/techo_vivienda_cubit.dart';
import '../../cubits/tenencia_vivienda/tenencia_vivienda_cubit.dart';
import '../../cubits/tiempo_tarda_ca/tiempo_tarda_ca_cubit.dart';
import '../../cubits/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_cubit.dart';
import '../../cubits/tipo_calendario/tipo_calendario_cubit.dart';
import '../../cubits/tipo_combustible_vivienda/tipo_combustible_vivienda_cubit.dart';
import '../../cubits/tipo_documento/tipo_documento_cubit.dart';
import '../../cubits/tipo_sanitario_vivienda/tipo_sanitario_vivienda_cubit.dart';
import '../../cubits/tipo_vivienda/tipo_vivienda_cubit.dart';
import '../../cubits/tratamiento_agua_vivienda/tratamiento_agua_vivienda_cubit.dart';
import '../../cubits/tuberculo_platano/tuberculo_platano_cubit.dart';
import '../../cubits/ultima_vez_inst_salud/ultima_vez_inst_salud_cubit.dart';
import '../../cubits/ventilacion_vivienda/ventilacion_vivienda_cubit.dart';
import '../../cubits/verdura/verdura_cubit.dart';
import '../../cubits/via_acceso/via_acceso_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/acceso_ca_form.dart';
import '../widgets/acceso_medico_form.dart';
import '../widgets/aspectos_tierra.dart';
import '../widgets/datos_ubicacion_form.dart';
import '../widgets/datos_vivienda_form.dart';
import '../widgets/grupo_familiar_form.dart';
import 'grupo_familiar_page.dart';

class FichaPage extends StatefulWidget {
  const FichaPage({super.key});

  @override
  State<FichaPage> createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  final _formKeyUbicacion = GlobalKey<FormState>();
  final _formKeyVivienda = GlobalKey<FormState>();
  int currentStep = 0;
  int registraAfiliados = 0;

  @override
  void initState() {
    super.initState();

    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    BlocProvider.of<DimUbicacionBloc>(context)
        .add(GetDimUbicacion(afiliado.afiliadoId!, afiliado.familiaId!));

    BlocProvider.of<DimViviendaBloc>(context)
        .add(GetDimVivienda(afiliado.afiliadoId!, afiliado.familiaId!));

    getAccesories();
  }

  getAccesories() {
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
    BlocProvider.of<MedioUtilizaMedTradicionalCubit>(context)
        .getMediosUtilizaMedTradicional();
    BlocProvider.of<EspecialidadMedTradicionalCubit>(context)
        .getEspecialidadesMedTradicionalDB();
    BlocProvider.of<TiempoTardaMedTradicionalCubit>(context)
        .getTiemposTardaMedTradicionalDB();
    BlocProvider.of<DificultadAccesoMedTradicionalCubit>(context)
        .getDificultadesAccesoMedTradicional();
    BlocProvider.of<OpcionSiNoCubit>(context).getOpcionesSiNoDB();
    BlocProvider.of<TipoViviendaCubit>(context).getTiposViviendaDB();
    BlocProvider.of<TenenciaViviendaCubit>(context).getTenenciasViviendaDB();
    BlocProvider.of<PisoViviendaCubit>(context).getPisosViviendaDB();
    BlocProvider.of<TechoViviendaCubit>(context).getTechosViviendaDB();
    BlocProvider.of<VentilacionViviendaCubit>(context)
        .getVentilacionesViviendaDB();
    BlocProvider.of<IluminacionViviendaCubit>(context)
        .getIluminacionesViviendaDB();
    BlocProvider.of<ServicioPublicoViviendaCubit>(context)
        .getServiciosPublicosDB();
    BlocProvider.of<TratamientoAguaViviendaCubit>(context)
        .getTratamientosAguaDB();
    BlocProvider.of<TipoSanitarioViviendaCubit>(context).getTiposSanitarioDB();
    BlocProvider.of<TipoCombustibleViviendaCubit>(context)
        .getTiposCombustibleDB();
    BlocProvider.of<FactorRiesgoViviendaCubit>(context).getFactoresRiesgoDB();
    BlocProvider.of<PresenciaAnimalViviendaCubit>(context)
        .getPresenciaAnimalesDB();
    BlocProvider.of<TuberculoPlatanoCubit>(context).getTuberculosPlatanosDB();
    BlocProvider.of<EspecieAnimalCubit>(context).getEspeciesAnimalesDB();
    BlocProvider.of<LeguminosaCubit>(context).getLeguminosasDB();
    BlocProvider.of<HortalizaCubit>(context).getHortalizasDB();
    BlocProvider.of<VerduraCubit>(context).getVerdurasDB();
    BlocProvider.of<FrutoCubit>(context).getFrutosDB();
    BlocProvider.of<CerealCubit>(context).getCerealesDB();
    BlocProvider.of<TipoCalendarioCubit>(context).getTiposCalendarioDB();
    BlocProvider.of<TipoDocumentoCubit>(context).getTiposDocumentoDB();
    BlocProvider.of<GeneroCubit>(context).getGenerosDB();
    BlocProvider.of<CursoVidaCubit>(context).getCursosVidaDB();
    BlocProvider.of<ParentescoCubit>(context).getParentescosDB();
    BlocProvider.of<RegimenCubit>(context).getRegimenesDB();
    BlocProvider.of<NivelEducativoCubit>(context).getNivelesEducativosDB();
    BlocProvider.of<OcupacionCubit>(context).getOcupacionesDB();
    BlocProvider.of<EtniaCubit>(context).getEtniasDB();
    BlocProvider.of<PuebloIndigenaCubit>(context).getPueblosIndigenasDB();
    BlocProvider.of<GrupoRiesgoCubit>(context).getGruposRiesgoDB();
    BlocProvider.of<LenguaManejaCubit>(context).getLenguasManejaDB();
    BlocProvider.of<NombreLenguaMaternaCubit>(context)
        .getNombresLenguasMaternaDB();
    BlocProvider.of<ActividadFisicaCubit>(context).getActividadFisicaDB();
    BlocProvider.of<AlimentacionCubit>(context).getAlimentacionDB();
    BlocProvider.of<CigarrilloDiaCubit>(context).getCigarrilloDiaDB();
    BlocProvider.of<ConsumoAlcoholCubit>(context).getConsumoAlcoholDB();
    BlocProvider.of<CondicionNutricionalCubit>(context)
        .getCondicionNutricionalDB();
    BlocProvider.of<ConductaSeguirCubit>(context).getConductaSeguirDB();
    BlocProvider.of<EsquemaVacunacionCubit>(context).getEsquemaVacunacionDB();
    BlocProvider.of<LugarVacunacionCubit>(context).getLugarVacunacionDB();
    BlocProvider.of<MetodoPlanificacionCubit>(context)
        .getMetodoPlanificacionDB();
    BlocProvider.of<NombreEnfermedadCubit>(context).getNombreEnfermedadDB();
    BlocProvider.of<SeguimientoEnfermedadCubit>(context)
        .getSeguimientoEnfermedadDB();
    BlocProvider.of<ServicioSolicitadoCubit>(context).getServicioSolicitadoDB();
    BlocProvider.of<UltimaVezInstSaludCubit>(context).getUltimaVezInstSaludDB();
    BlocProvider.of<ReligionProfesaCubit>(context).getReligionProfesaDB();
    BlocProvider.of<EventoCostumbreParticipaCubit>(context)
        .getEventosCostumbresParticipaDB();
    BlocProvider.of<CostumbrePracticaCubit>(context).getCostumbrePracticaDB();
    BlocProvider.of<SancionJusticiaCubit>(context).getSancionJusticiaDB();
    BlocProvider.of<EnfermedadAcudeCubit>(context).getEnfermedadAcudeDB();
    BlocProvider.of<EnfermedadTradicionalCubit>(context)
        .getEnfermedadTradicionalDB();
    BlocProvider.of<LugarAtencionMedicoCubit>(context)
        .getLugaresAtencionMedicoDB();
    BlocProvider.of<EnfermedadTratamientoCubit>(context)
        .getEnfermedadTratamientoDB();
    BlocProvider.of<LugarPlantaMedicinalCubit>(context)
        .getLugarPlantaMedicinalDB();
    BlocProvider.of<PlantaMedicinalCubit>(context).getPlantasMedicinalesDB();
    BlocProvider.of<NroCuartoViviendaCubit>(context).getNroCuartosViviendaDB();
    BlocProvider.of<ResguardoCubit>(context).getResguardosDB();
  }

  @override
  Widget build(BuildContext context) {
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
    final dimViviendaBloc = BlocProvider.of<DimViviendaBloc>(context);
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);

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
              BlocListener<DimUbicacionBloc, DimUbicacionEntity>(
                listener: (context, state) {
                  final formStatus = state.formStatus;
                  if (formStatus is DimUbicacionSubmissionSuccess) {
                    CustomSnackBar.showSnackBar(
                        context,
                        'Datos de ubicación guardados correctamente',
                        Colors.green);

                    setState(() {
                      currentStep = 1;
                    });
                  }
                  if (formStatus is DimUbicacionSubmissionFailed) {
                    CustomSnackBar.showSnackBar(
                        context, formStatus.message, Colors.red);
                  }
                },
              ),
              BlocListener<DimViviendaBloc, DimViviendaEntity>(
                listener: (context, state) {
                  final formStatus = state.formStatus;
                  if (formStatus is DimViviendaSubmissionSuccess) {
                    CustomSnackBar.showSnackBar(
                        context,
                        'Datos de vivienda guardados correctamente',
                        Colors.green);

                    setState(() {
                      currentStep = 2;
                    });
                  }
                  if (formStatus is DimViviendaSubmissionFailed) {
                    CustomSnackBar.showSnackBar(
                        context, formStatus.message, Colors.red);
                  }
                },
              ),
              BlocListener<AfiliadosGrupoFamiliarBloc,
                  AfiliadosGrupoFamiliarState>(
                listener: (context, state) {
                  if (state is GrupoFamiliarSubmissionSuccess) {
                    CustomSnackBar.showSnackBar(
                        context,
                        'Datos del grupo familiar guardados correctamente',
                        Colors.green);

                    Navigator.pushReplacementNamed(
                        context, 'estilo-vida-saludable');
                  }
                  if (state is GrupoFamiliarSubmissionFailed) {
                    CustomSnackBar.showSnackBar(
                        context, state.message, Colors.red);
                  }
                  if (state is AfiliadosGrupoFamiliarError) {
                    CustomSnackBar.showSnackBar(
                        context, state.message, Colors.red);
                  }
                },
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Ficha'),
              ),
              body: Theme(
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
                            DimUbicacionAfiliadoChanged(afiliado.afiliadoId!));
                        dimUbicacionBloc.add(
                            DimUbicacionFamiliaChanged(afiliado.familiaId!));
                        dimUbicacionBloc.add(DimUbicacionSubmitted());
                      }
                    } else if (currentStep == 1) {
                      if (_formKeyVivienda.currentState!.validate()) {
                        _formKeyVivienda.currentState!.save();
                        dimViviendaBloc.add(
                            DimViviendaAfiliadoChanged(afiliado.afiliadoId!));
                        dimViviendaBloc.add(
                            DimViviendaFamiliaChanged(afiliado.familiaId!));
                        dimViviendaBloc.add(DimViviendaSubmitted());
                      }
                    } else if (isLastStep) {
                      final afiliadosGrupoFamiliar = afiliadosGrupoFamiliarBloc
                          .state.afiliadosGrupoFamiliar;

                      if (afiliadosGrupoFamiliar != null &&
                          registraAfiliados == 0) {
                        afiliadosGrupoFamiliarBloc.add(
                            SaveAfiliadosGrupoFamiliar(afiliadosGrupoFamiliar));

                        encuestaBloc
                            .add(SaveAfiliadosEncuesta(afiliadosGrupoFamiliar));
                      } else if (registraAfiliados == 1) {
                        final afiliadoGrupoFamiliar = GrupoFamiliarEntity(
                            afiliadoId: afiliado.afiliadoId,
                            documento: afiliado.documento,
                            edad: afiliado.edad,
                            fechaNacimiento: afiliado.fecnac,
                            nombre1: afiliado.nombre1,
                            nombre2: afiliado.nombre2,
                            apellido1: afiliado.apellido1,
                            apellido2: afiliado.apellido2,
                            tipoDocAfiliado: afiliado.tipoDocAfiliado,
                            codGeneroAfiliado: afiliado.codGeneroAfiliado,
                            codRegimenAfiliado: afiliado.codRegimenAfiliado,
                            isCompleted: true);

                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                GrupoFamiliarForm(
                                    afiliadoGrupoFamiliar:
                                        afiliadoGrupoFamiliar),
                          ),
                        );
                      } else {
                        afiliadosGrupoFamiliarBloc.add(const ErrorMessage(
                            'No hay afiliados en el grupo familiar'));
                      }
                    }
                  },
                  controlsBuilder: (context, details) {
                    return BlocBuilder<AfiliadosGrupoFamiliarBloc,
                        AfiliadosGrupoFamiliarState>(
                      builder: (context, state) {
                        return Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: Row(children: [
                            ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: const Text('Continuar'),
                            ),
                          ]),
                        );
                      },
                    );
                  },
                ),
              ),
            )));
  }

  List<Step> getSteps() => [
        ubicacionStep(),
        viviendaStep(),
        grupoFamiliarStep(),
      ];

  Step ubicacionStep() {
    return Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: const Text('Ubicación'),
      content: BlocBuilder<DimUbicacionBloc, DimUbicacionEntity>(
        builder: (context, state) {
          if (state.formStatus is DimUbicacionFormEmpty) {
            return Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
    );
  }

  Step viviendaStep() {
    return Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: const Text('Vivienda'),
      content: BlocBuilder<DimViviendaBloc, DimViviendaEntity>(
        builder: (context, state) {
          if (state.formStatus is DimViviendaFormEmpty) {
            return Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeyVivienda,
                child: const DatosViviendaForm());
          } else if (state.formStatus is DimViviendaFormLoaded ||
              state.formStatus is DimViviendaSubmissionSuccess) {
            return Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeyVivienda,
                child: DatosViviendaForm(
                  dimVivienda: state,
                ));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Step grupoFamiliarStep() {
    return Step(
        isActive: currentStep >= 2,
        title: const Text('Grupo Familiar'),
        content: Column(
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
              onChanged: (int? value) async {
                setState(() {
                  registraAfiliados = value!;
                });
              },
            ),
            GrupoFamiliarPage(
              registraAfiliados: registraAfiliados,
            ),
          ],
        ));
  }
}
