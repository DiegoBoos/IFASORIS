import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/app_config.dart';
import '../../../core/constants.dart';
import '../../../data/models/afiliado.dart';
import '../../../data/models/sync_progress.dart';
import '../../../domain/usecases/actividad_fisica/actividad_fisica_exports.dart';
import '../../../domain/usecases/afiliado/afiliado_exports.dart';
import '../../../domain/usecases/alimentacion/alimentacion_exports.dart';
import '../../../domain/usecases/autoridad_indigena/autoridad_indigena_exports.dart';
import '../../../domain/usecases/cereal/cereal_exports.dart';
import '../../../domain/usecases/cigarrillo_dia/cigarrillo_dia_exports.dart';
import '../../../domain/usecases/condicion_nutricional/condicion_nutricional_exports.dart';
import '../../../domain/usecases/conducta_seguir/conducta_seguir_exports.dart';
import '../../../domain/usecases/consumo_alcohol/consumo_alcohol_exports.dart';
import '../../../domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import '../../../domain/usecases/costumbre_practica/costumbre_practica_exports.dart';
import '../../../domain/usecases/nro_cuarto_vivienda/nro_cuarto_vivienda_exports.dart';
import '../../../domain/usecases/curso_vida/curso_vida_exports.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_exports.dart';
import '../../../domain/usecases/enfermedad_acude/enfermedad_acude_exports.dart';
import '../../../domain/usecases/enfermedad_tradicional/enfermedad_tradicional_exports.dart';
import '../../../domain/usecases/enfermedad_tratamiento/enfermedad_tratamiento_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional/especialidad_med_tradicional_exports.dart';
import '../../../domain/usecases/especie_animal/especie_animal_exports.dart';
import '../../../domain/usecases/esquema_vacunacion/esquema_vacunacion_exports.dart';
import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/etnia/etnia_exports.dart';
import '../../../domain/usecases/evento_costumbre_participa/evento_costumbre_participa_exports.dart';
import '../../../domain/usecases/factor_riesgo_vivienda/factor_riesgo_vivienda_exports.dart';
import '../../../domain/usecases/ficha/ficha_exports.dart';
import '../../../domain/usecases/fruto/fruto_exports.dart';
import '../../../domain/usecases/genero/genero_exports.dart';
import '../../../domain/usecases/grupo_riesgo/grupo_riesgo_exports.dart';
import '../../../domain/usecases/hortaliza/hortaliza_exports.dart';
import '../../../domain/usecases/iluminacion_vivienda/iluminacion_vivienda_exports.dart';
import '../../../domain/usecases/leguminosa/leguminosa_exports.dart';
import '../../../domain/usecases/lengua_maneja/lengua_maneja_exports.dart';
import '../../../domain/usecases/lugar_atencion_medico/lugar_atencion_medico_exports.dart';
import '../../../domain/usecases/lugar_planta_medicinal/lugar_planta_medicinal_exports.dart';
import '../../../domain/usecases/lugar_vacunacion/lugar_vacunacion_exports.dart';
import '../../../domain/usecases/medio_comunicacion/medio_comunicacion_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_exports.dart';
import '../../../domain/usecases/metodo_planificacion/metodo_planificacion_exports.dart';
import '../../../domain/usecases/nivel_educativo/nivel_educativo_exports.dart';
import '../../../domain/usecases/nombre_enfermedad/nombre_enfermedad_exports.dart';
import '../../../domain/usecases/nombre_lengua_materna/nombre_lengua_materna_exports.dart';
import '../../../domain/usecases/ocupacion/ocupacion_exports.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../../domain/usecases/parentesco/parentesco_exports.dart';
import '../../../domain/usecases/piso_vivienda/piso_vivienda_exports.dart';
import '../../../domain/usecases/planta_medicinal/planta_medicinal_exports.dart';
import '../../../domain/usecases/presencia_animal_vivienda/presencia_animal_vivienda_exports.dart';
import '../../../domain/usecases/pueblo_indigena/pueblo_indigena_exports.dart';
import '../../../domain/usecases/tipo_regimen/tipo_regimen_exports.dart';
import '../../../domain/usecases/religion_profesa/religion_profesa_exports.dart';
import '../../../domain/usecases/resguardo/resguardo_exports.dart';
import '../../../domain/usecases/sancion_justicia/sancion_justicia_exports.dart';
import '../../../domain/usecases/seguimiento_enfermedad/seguimiento_enfermedad_exports.dart';
import '../../../domain/usecases/servicio_publico_vivienda/servicio_publico_vivienda_exports.dart';
import '../../../domain/usecases/servicio_solicitado/servicio_solicitado_exports.dart';
import '../../../domain/usecases/techo_vivienda/techo_vivienda_exports.dart';
import '../../../domain/usecases/tenencia_vivienda/tenencia_vivienda_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import '../../../domain/usecases/tipo_calendario/tipo_calendario_exports.dart';
import '../../../domain/usecases/tipo_combustible_vivienda/tipo_combustible_vivienda_exports.dart';
import '../../../domain/usecases/tipo_documento/tipo_documento_exports.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda/tipo_sanitario_vivienda_exports.dart';
import '../../../domain/usecases/tipo_vivienda/tipo_vivienda_exports.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda/tratamiento_agua_vivienda_exports.dart';
import '../../../domain/usecases/tuberculo_platano/tuberculo_platano_exports.dart';
import '../../../domain/usecases/ultima_vez_inst_salud/ultima_vez_inst_salud_exports.dart';
import '../../../domain/usecases/ventilacion_vivienda/ventilacion_vivienda_exports.dart';
import '../../../domain/usecases/verdura/verdura_exports.dart';
import '../../../domain/usecases/via_acceso/via_acceso_exports.dart';
import '../../../services/shared_preferences_service.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final AfiliadoUsecase afiliadoUsecase;
  final AfiliadoUsecaseDB afiliadoUsecaseDB;
  final DificultadAccesoCAUsecase dificultadAccesoCAUsecase;
  final DificultadAccesoCAUsecaseDB dificultadAccesoCAUsecaseDB;
  final EstadoViaUsecase estadoViaUsecase;
  final EstadoViaUsecaseDB estadoViaUsecaseDB;
  final MedioComunicacionUsecase medioComunicacionUsecase;
  final MedioComunicacionUsecaseDB medioComunicacionUsecaseDB;
  final MedioUtilizaCAUsecase medioUtilizaCAUsecase;
  final MedioUtilizaCAUsecaseDB medioUtilizaCAUsecaseDB;
  final TiempoTardaCAUsecase tiempoTardaCAUsecase;
  final TiempoTardaCAUsecaseDB tiempoTardaCAUsecaseDB;
  final ViaAccesoUsecase viaAccesoUsecase;
  final ViaAccesoUsecaseDB viaAccesoUsecaseDB;
  final AutoridadIndigenaUsecase autoridadIndigenaUsecase;
  final AutoridadIndigenaUsecaseDB autoridadIndigenaUsecaseDB;
  final CerealUsecase cerealUsecase;
  final CerealUsecaseDB cerealUsecaseDB;
  final CostoDesplazamientoUsecase costoDesplazamientoUsecase;
  final CostoDesplazamientoUsecaseDB costoDesplazamientoUsecaseDB;
  final DificultadAccesoMedTradicionalUsecase
      dificultadAccesoMedTradicionalUsecase;
  final DificultadAccesoMedTradicionalUsecaseDB
      dificultadAccesoMedTradicionalUsecaseDB;
  final EspecialidadMedTradicionalUsecase especialidadMedTradicionalUsecase;
  final EspecialidadMedTradicionalUsecaseDB especialidadMedTradicionalUsecaseDB;
  final EspecieAnimalUsecase especieAnimalUsecase;
  final EspecieAnimalUsecaseDB especieAnimalUsecaseDB;
  final FrutoUsecase frutoUsecase;
  final FrutoUsecaseDB frutoUsecaseDB;
  final HortalizaUsecase hortalizaUsecase;
  final HortalizaUsecaseDB hortalizaUsecaseDB;
  final LeguminosaUsecase leguminosaUsecase;
  final LeguminosaUsecaseDB leguminosaUsecaseDB;
  final MedioUtilizaMedTradicionalUsecase medioUtilizaMedTradicionalUsecase;
  final MedioUtilizaMedTradicionalUsecaseDB medioUtilizaMedTradicionalUsecaseDB;
  final OpcionSiNoUsecase opcionSiNoUsecase;
  final OpcionSiNoUsecaseDB opcionSiNoUsecaseDB;
  final ResguardoUsecase resguardoUsecase;
  final ResguardoUsecaseDB resguardoUsecaseDB;
  final TiempoTardaMedTradicionalUsecase tiempoTardaMedTradicionalUsecase;
  final TiempoTardaMedTradicionalUsecaseDB tiempoTardaMedTradicionalUsecaseDB;
  final TuberculoPlatanoUsecase tuberculoPlatanoUsecase;
  final TuberculoPlatanoUsecaseDB tuberculoPlatanoUsecaseDB;
  final VerduraUsecase verduraUsecase;
  final VerduraUsecaseDB verduraUsecaseDB;
  final FactorRiesgoViviendaUsecase factorRiesgoViviendaUsecase;
  final FactorRiesgoViviendaUsecaseDB factorRiesgoViviendaUsecaseDB;
  final IluminacionViviendaUsecase iluminacionViviendaUsecase;
  final IluminacionViviendaUsecaseDB iluminacionViviendaUsecaseDB;
  final PisoViviendaUsecase pisoViviendaUsecase;
  final PisoViviendaUsecaseDB pisoViviendaUsecaseDB;
  final PresenciaAnimalViviendaUsecase presenciaAnimalViviendaUsecase;
  final PresenciaAnimalViviendaUsecaseDB presenciaAnimalViviendaUsecaseDB;
  final ServicioPublicoViviendaUsecase servicioPublicoViviendaUsecase;
  final ServicioPublicoViviendaUsecaseDB servicioPublicoViviendaUsecaseDB;
  final TechoViviendaUsecase techoViviendaUsecase;
  final TechoViviendaUsecaseDB techoViviendaUsecaseDB;
  final TenenciaViviendaUsecase tenenciaViviendaUsecase;
  final TenenciaViviendaUsecaseDB tenenciaViviendaUsecaseDB;
  final TipoCombustibleViviendaUsecase tipoCombustibleViviendaUsecase;
  final TipoCombustibleViviendaUsecaseDB tipoCombustibleViviendaUsecaseDB;
  final TipoSanitarioViviendaUsecase tipoSanitarioViviendaUsecase;
  final TipoSanitarioViviendaUsecaseDB tipoSanitarioViviendaUsecaseDB;
  final TratamientoAguaViviendaUsecase tratamientoAguaViviendaUsecase;
  final TratamientoAguaViviendaUsecaseDB tratamientoAguaViviendaUsecaseDB;
  final VentilacionViviendaUsecase ventilacionViviendaUsecase;
  final VentilacionViviendaUsecaseDB ventilacionViviendaUsecaseDB;
  final TipoViviendaUsecase tipoViviendaUsecase;
  final TipoViviendaUsecaseDB tipoViviendaUsecaseDB;
  final TipoCalendarioUsecase tipoCalendarioUsecase;
  final TipoCalendarioUsecaseDB tipoCalendarioUsecaseDB;
  final CursoVidaUsecase cursoVidaUsecase;
  final CursoVidaUsecaseDB cursoVidaUsecaseDB;
  final EtniaUsecase etniaUsecase;
  final EtniaUsecaseDB etniaUsecaseDB;
  final GeneroUsecase generoUsecase;
  final GeneroUsecaseDB generoUsecaseDB;
  final GrupoRiesgoUsecase grupoRiesgoUsecase;
  final GrupoRiesgoUsecaseDB grupoRiesgoUsecaseDB;
  final LenguaManejaUsecase lenguaManejaUsecase;
  final LenguaManejaUsecaseDB lenguaManejaUsecaseDB;
  final NivelEducativoUsecase nivelEducativoUsecase;
  final NivelEducativoUsecaseDB nivelEducativoUsecaseDB;
  final NombreLenguaMaternaUsecase nombreLenguaMaternaUsecase;
  final NombreLenguaMaternaUsecaseDB nombreLenguaMaternaUsecaseDB;
  final OcupacionUsecase ocupacionUsecase;
  final OcupacionUsecaseDB ocupacionUsecaseDB;
  final ParentescoUsecase parentescoUsecase;
  final ParentescoUsecaseDB parentescoUsecaseDB;
  final PuebloIndigenaUsecase puebloIndigenaUsecase;
  final PuebloIndigenaUsecaseDB puebloIndigenaUsecaseDB;
  final TipoRegimenUsecase tiporegimenUsecase;
  final TipoRegimenUsecaseDB tiporegimenUsecaseDB;
  final TipoDocumentoUsecase tipoDocumentoUsecase;
  final TipoDocumentoUsecaseDB tipoDocumentoUsecaseDB;
  final ActividadFisicaUsecase actividadFisicaUsecase;
  final ActividadFisicaUsecaseDB actividadFisicaUsecaseDB;
  final AlimentacionUsecase alimentacionUsecase;
  final AlimentacionUsecaseDB alimentacionUsecaseDB;
  final CigarrilloDiaUsecase cigarrilloDiaUsecase;
  final CigarrilloDiaUsecaseDB cigarrilloDiaUsecaseDB;
  final ConsumoAlcoholUsecase consumoAlcoholUsecase;
  final ConsumoAlcoholUsecaseDB consumoAlcoholUsecaseDB;
  final CondicionNutricionalUsecase condicionNutricionalUsecase;
  final CondicionNutricionalUsecaseDB condicionNutricionalUsecaseDB;
  final ConductaSeguirUsecase conductaSeguirUsecase;
  final ConductaSeguirUsecaseDB conductaSeguirUsecaseDB;
  final EsquemaVacunacionUsecase esquemaVacunacionUsecase;
  final EsquemaVacunacionUsecaseDB esquemaVacunacionUsecaseDB;
  final LugarVacunacionUsecase lugarVacunacionUsecase;
  final LugarVacunacionUsecaseDB lugarVacunacionUsecaseDB;
  final MetodoPlanificacionUsecase metodoPlanificacionUsecase;
  final MetodoPlanificacionUsecaseDB metodoPlanificacionUsecaseDB;
  final NombreEnfermedadUsecase nombreEnfermedadUsecase;
  final NombreEnfermedadUsecaseDB nombreEnfermedadUsecaseDB;
  final SeguimientoEnfermedadUsecase seguimientoEnfermedadUsecase;
  final SeguimientoEnfermedadUsecaseDB seguimientoEnfermedadUsecaseDB;
  final ServicioSolicitadoUsecase servicioSolicitadoUsecase;
  final ServicioSolicitadoUsecaseDB servicioSolicitadoUsecaseDB;
  final UltimaVezInstSaludUsecase ultimaVezInstSaludUsecase;
  final UltimaVezInstSaludUsecaseDB ultimaVezInstSaludUsecaseDB;
  final EnfermedadAcudeUsecase enfermedadAcudeUsecase;
  final EnfermedadAcudeUsecaseDB enfermedadAcudeUsecaseDB;
  final EnfermedadTratamientoUsecase enfermedadTratamientoUsecase;
  final EnfermedadTratamientoUsecaseDB enfermedadTratamientoUsecaseDB;
  final EnfermedadTradicionalUsecase enfermedadTradicionalUsecase;
  final EnfermedadTradicionalUsecaseDB enfermedadTradicionalUsecaseDB;
  final LugarAtencionMedicoUsecase lugarAtencionMedicoUsecase;
  final LugarAtencionMedicoUsecaseDB lugarAtencionMedicoUsecaseDB;
  final LugarPlantaMedicinalUsecase lugarPlantaMedicinalUsecase;
  final LugarPlantaMedicinalUsecaseDB lugarPlantaMedicinalUsecaseDB;
  final PlantaMedicinalUsecase plantaMedicinalUsecase;
  final PlantaMedicinalUsecaseDB plantaMedicinalUsecaseDB;
  final ReligionProfesaUsecase religionProfesaUsecase;
  final ReligionProfesaUsecaseDB religionProfesaUsecaseDB;
  final EventoCostumbreParticipaUsecase eventoCostumbreParticipaUsecase;
  final EventoCostumbreParticipaUsecaseDB eventoCostumbreParticipaUsecaseDB;
  final CostumbrePracticaUsecase costumbrePracticaUsecase;
  final CostumbrePracticaUsecaseDB costumbrePracticaUsecaseDB;
  final SancionJusticiaUsecase sancionJusticiaUsecase;
  final SancionJusticiaUsecaseDB sancionJusticiaUsecaseDB;
  final NroCuartoViviendaUsecase nroCuartoViviendaUsecase;
  final NroCuartoViviendaUsecaseDB nroCuartoViviendaUsecaseDB;
  final FichaUsecase fichaUsecase;
  final FichaUsecaseDB fichaUsecaseDB;

  final prefs = SharedPreferencesService();

  int successfulAfiliadoInserts = 0;

  List<FichaEntity> fichasTemp = [];
  int countRecordsFichasTemp = 0;

  SyncBloc({
    required this.afiliadoUsecase,
    required this.afiliadoUsecaseDB,
    required this.dificultadAccesoCAUsecase,
    required this.dificultadAccesoCAUsecaseDB,
    required this.estadoViaUsecase,
    required this.estadoViaUsecaseDB,
    required this.medioComunicacionUsecase,
    required this.medioComunicacionUsecaseDB,
    required this.medioUtilizaCAUsecase,
    required this.medioUtilizaCAUsecaseDB,
    required this.tiempoTardaCAUsecase,
    required this.tiempoTardaCAUsecaseDB,
    required this.viaAccesoUsecase,
    required this.viaAccesoUsecaseDB,
    required this.autoridadIndigenaUsecase,
    required this.autoridadIndigenaUsecaseDB,
    required this.cerealUsecase,
    required this.cerealUsecaseDB,
    required this.costoDesplazamientoUsecase,
    required this.costoDesplazamientoUsecaseDB,
    required this.dificultadAccesoMedTradicionalUsecase,
    required this.dificultadAccesoMedTradicionalUsecaseDB,
    required this.especialidadMedTradicionalUsecase,
    required this.especialidadMedTradicionalUsecaseDB,
    required this.especieAnimalUsecase,
    required this.especieAnimalUsecaseDB,
    required this.frutoUsecase,
    required this.frutoUsecaseDB,
    required this.hortalizaUsecase,
    required this.hortalizaUsecaseDB,
    required this.leguminosaUsecase,
    required this.leguminosaUsecaseDB,
    required this.medioUtilizaMedTradicionalUsecase,
    required this.medioUtilizaMedTradicionalUsecaseDB,
    required this.opcionSiNoUsecase,
    required this.opcionSiNoUsecaseDB,
    required this.resguardoUsecase,
    required this.resguardoUsecaseDB,
    required this.tiempoTardaMedTradicionalUsecase,
    required this.tiempoTardaMedTradicionalUsecaseDB,
    required this.tuberculoPlatanoUsecase,
    required this.tuberculoPlatanoUsecaseDB,
    required this.verduraUsecase,
    required this.verduraUsecaseDB,
    required this.factorRiesgoViviendaUsecase,
    required this.factorRiesgoViviendaUsecaseDB,
    required this.iluminacionViviendaUsecase,
    required this.iluminacionViviendaUsecaseDB,
    required this.pisoViviendaUsecase,
    required this.pisoViviendaUsecaseDB,
    required this.presenciaAnimalViviendaUsecase,
    required this.presenciaAnimalViviendaUsecaseDB,
    required this.servicioPublicoViviendaUsecase,
    required this.servicioPublicoViviendaUsecaseDB,
    required this.techoViviendaUsecase,
    required this.techoViviendaUsecaseDB,
    required this.tenenciaViviendaUsecase,
    required this.tenenciaViviendaUsecaseDB,
    required this.tipoCombustibleViviendaUsecase,
    required this.tipoCombustibleViviendaUsecaseDB,
    required this.tipoSanitarioViviendaUsecase,
    required this.tipoSanitarioViviendaUsecaseDB,
    required this.tratamientoAguaViviendaUsecase,
    required this.tratamientoAguaViviendaUsecaseDB,
    required this.ventilacionViviendaUsecase,
    required this.ventilacionViviendaUsecaseDB,
    required this.tipoViviendaUsecase,
    required this.tipoViviendaUsecaseDB,
    required this.tipoCalendarioUsecase,
    required this.tipoCalendarioUsecaseDB,
    required this.cursoVidaUsecase,
    required this.cursoVidaUsecaseDB,
    required this.etniaUsecase,
    required this.etniaUsecaseDB,
    required this.generoUsecase,
    required this.generoUsecaseDB,
    required this.grupoRiesgoUsecase,
    required this.grupoRiesgoUsecaseDB,
    required this.lenguaManejaUsecase,
    required this.lenguaManejaUsecaseDB,
    required this.nivelEducativoUsecase,
    required this.nivelEducativoUsecaseDB,
    required this.nombreLenguaMaternaUsecase,
    required this.nombreLenguaMaternaUsecaseDB,
    required this.ocupacionUsecase,
    required this.ocupacionUsecaseDB,
    required this.parentescoUsecase,
    required this.parentescoUsecaseDB,
    required this.puebloIndigenaUsecase,
    required this.puebloIndigenaUsecaseDB,
    required this.tiporegimenUsecase,
    required this.tiporegimenUsecaseDB,
    required this.tipoDocumentoUsecase,
    required this.tipoDocumentoUsecaseDB,
    required this.actividadFisicaUsecase,
    required this.actividadFisicaUsecaseDB,
    required this.alimentacionUsecase,
    required this.alimentacionUsecaseDB,
    required this.cigarrilloDiaUsecase,
    required this.cigarrilloDiaUsecaseDB,
    required this.consumoAlcoholUsecase,
    required this.consumoAlcoholUsecaseDB,
    required this.condicionNutricionalUsecase,
    required this.condicionNutricionalUsecaseDB,
    required this.conductaSeguirUsecase,
    required this.conductaSeguirUsecaseDB,
    required this.esquemaVacunacionUsecase,
    required this.esquemaVacunacionUsecaseDB,
    required this.lugarVacunacionUsecase,
    required this.lugarVacunacionUsecaseDB,
    required this.metodoPlanificacionUsecase,
    required this.metodoPlanificacionUsecaseDB,
    required this.nombreEnfermedadUsecase,
    required this.nombreEnfermedadUsecaseDB,
    required this.seguimientoEnfermedadUsecase,
    required this.seguimientoEnfermedadUsecaseDB,
    required this.servicioSolicitadoUsecase,
    required this.servicioSolicitadoUsecaseDB,
    required this.ultimaVezInstSaludUsecase,
    required this.ultimaVezInstSaludUsecaseDB,
    required this.enfermedadAcudeUsecase,
    required this.enfermedadAcudeUsecaseDB,
    required this.enfermedadTratamientoUsecase,
    required this.enfermedadTratamientoUsecaseDB,
    required this.enfermedadTradicionalUsecase,
    required this.enfermedadTradicionalUsecaseDB,
    required this.lugarAtencionMedicoUsecase,
    required this.lugarAtencionMedicoUsecaseDB,
    required this.lugarPlantaMedicinalUsecase,
    required this.lugarPlantaMedicinalUsecaseDB,
    required this.plantaMedicinalUsecase,
    required this.plantaMedicinalUsecaseDB,
    required this.religionProfesaUsecase,
    required this.religionProfesaUsecaseDB,
    required this.eventoCostumbreParticipaUsecase,
    required this.eventoCostumbreParticipaUsecaseDB,
    required this.costumbrePracticaUsecase,
    required this.costumbrePracticaUsecaseDB,
    required this.sancionJusticiaUsecase,
    required this.sancionJusticiaUsecaseDB,
    required this.nroCuartoViviendaUsecase,
    required this.nroCuartoViviendaUsecaseDB,
    required this.fichaUsecase,
    required this.fichaUsecaseDB,
  }) : super(SyncInitial()) {
    on<InitSync>((event, emit) => emit(SyncInitial()));
    on<SyncStarted>((event, emit) async {
      if (event.type == 'A') {
        add(Downloading(state.syncProgressModel.copyWith(
          title: 'Descargando afiliados',
        )));

        await syncAfiliados(event);
      } else if (event.type == 'P') {
        await uploadFichas(event);
      }
    });
    on<Downloading>((event, emit) => emit(SyncDownloading(event.syncProgress)));
    on<SyncPercentageChanged>((event, emit) {
      event.syncProgress.counter == event.syncProgress.total
          ? emit(SyncSuccess())
          : emit(SyncPercentageInProgress(event.syncProgress));
    });
    on<SyncIncrementChanged>((event, emit) {
      event.syncProgress.counter == event.syncProgress.total
          ? emit(SyncSuccess())
          : emit(SyncIncrementInProgress(event.syncProgress));
    });
    on<SyncError>((event, emit) => emit(SyncFailure(event.message)));
  }

  int calculatePercent(int counter, int total) {
    final percent = ((counter / total) * 100).toInt();
    return percent;
  }

// ************************** Ficha ****************************
  Future<void> uploadFichas(
    SyncStarted event,
  ) async {
    final completer = Completer<void>();

    final result = await fichaUsecase.createFichaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      final uri = Uri.parse('${AppConfig.syncPublica}/ficha');
      final fichasSync = [];

      for (var i = 0; i < data.length; i++) {
        final fichaIdLocal = data[i]['Ficha_id'];
        final ficha = data[i];

        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/data.json');

        // Escribe la cadena JSON en el archivo
        await file.writeAsString(jsonEncode(ficha));

        final syncProgressModel = state.syncProgressModel.copyWith(
          title: 'Sincronizando Ficha',
          counter: i + 1,
          total: data.length,
          percent: calculatePercent(i, data.length),
        );

        add(Downloading(syncProgressModel));
        ficha['Ficha_id'] = 0; // Para nueva Ficha se envia id 0
        final resp = await http.post(uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${prefs.token}',
            },
            body: jsonEncode(ficha));

        final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
        if (resp.statusCode == 200 || resp.statusCode == 201) {
          final fichaRemote = decodedResp['ficha'];
          // ficha.numFicha = fichaRemote['NumFicha'];
          fichasSync.add(ficha);

          await supabase
              .from('Ficha')
              .update({'NumFicha': fichaRemote['numFicha']}).eq(
                  'Ficha_id', fichaIdLocal);

          add(SyncIncrementChanged(state.syncProgressModel.copyWith(
            title: 'Se sincronizaron: ${fichasSync.length} fichas',
          )));
        } else {
          add(SyncError(decodedResp['message']));
        }
      }
    });
  }
// ************************** Ficha ****************************

// ************************** Afiliados ****************************
  Future<void> syncAfiliados(SyncStarted event) async {
    int limit = 5000;
    int municipioId = event.user.userMetadata!['Municipio_id'];
    List<dynamic> afiliadosMap = [];
    List<Map<String, dynamic>> combinedList = [];

    final requestUrl =
        Uri.parse('${AppConfig.syncPublica}/afiliados/$municipioId/$limit');

    final resp = await http.get(requestUrl);

    if (resp.statusCode == 200) {
      final decodedResp = json.decode(resp.body);
      final int totalRecords = decodedResp['totalRecords'];
      final int loopValue = decodedResp['loopValue'];

      for (var i = 0; i < loopValue; i++) {
        final afiliadosUrl = Uri.parse(
            '${AppConfig.syncPublica}/afiliados/afiliadosbympio?limit=$limit&page=$i&mpioId=$municipioId');
        final afiliadosResp = await http.get(afiliadosUrl);

        if (afiliadosResp.statusCode == 200) {
          final decodeReq = json.decode(afiliadosResp.body);
          afiliadosMap.addAll(decodeReq);
        } else {
          add(const SyncError('Excepción no controlada'));
        }

        final syncProgressModel = state.syncProgressModel.copyWith(
          title: 'Descargando afiliados',
          counter: i,
          total: loopValue,
          percent: calculatePercent(i + 1, loopValue),
        );

        add(Downloading(syncProgressModel));
      }

      combinedList =
          afiliadosMap.map((e) => e as Map<String, dynamic>).toList();

      final afiliadoResp = {
        "totalRecords": totalRecords,
        "afiliados": combinedList
      };

      await saveAfiliados(event, AfiliadoResponseModel.fromJson(afiliadoResp));
    } else {
      add(const SyncError('Excepción no controlada'));
    }
  }

  Future<void> saveAfiliados(
      SyncStarted event, AfiliadoResponseModel afiliadosRes) async {
    final completer = Completer<void>();

    for (int i = 0; i < afiliadosRes.resultado.length; i++) {
      final afiliado = afiliadosRes.resultado[i];

      final saveAfiliado =
          await afiliadoUsecaseDB.saveAfiliadoUsecaseDB(afiliado);

      saveAfiliado.fold((failure) {
        add(SyncError(failure.properties.first));
        completer.completeError(failure);
      }, (_) {
        final syncProgressModel = state.syncProgressModel.copyWith(
          title: 'Sincronizando afiliados',
          counter: i + 1,
          percent: calculatePercent(i + 1, afiliadosRes.resultado.length - 1),
        );

        add(Downloading(syncProgressModel));
      });
    }

    if (!completer.isCompleted) {
      await syncDificultadesAccesoCA(event);
      completer.complete();
    }

    return completer.future;
  }

// ************************** Afiliados ****************************

// ************************** Dificultades acceso CA ****************************

  Future<void> syncDificultadesAccesoCA(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await dificultadAccesoCAUsecase.getDificultadesAccesoCAUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando dificultades acceso',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await dificultadAccesoCAUsecaseDB
            .saveDificultadAccesoCAUsecase(data[i]);

        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEstadoVias(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Dificultades acceso CA ****************************

// ************************** Estado Vias ****************************

  Future<void> syncEstadoVias(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await estadoViaUsecase.getEstadoViasUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando estados vías',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await estadoViaUsecaseDB.saveEstadoViaUsecase(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncMediosComunicacion(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Estado Vias ****************************

// ************************** Medios comunicacion ****************************

  Future<void> syncMediosComunicacion(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await medioComunicacionUsecase.getMediosComunicacionUsecase(
        event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios comunicación',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await medioComunicacionUsecaseDB
            .saveMedioComunicacionUsecase(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncMediosUtilizaCA(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Medios comunicacion ****************************

// ************************** Medios utiliza CA ****************************

  Future<void> syncMediosUtilizaCA(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await medioUtilizaCAUsecase
        .getMediosUtilizaCAUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios utiliza centro atención',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await medioUtilizaCAUsecaseDB.saveMedioUtilizaCAUsecase(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTiemposTardaCA(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Medios utiliza CA ****************************

// ************************** Tiempos tarda CA ****************************

  Future<void> syncTiemposTardaCA(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await tiempoTardaCAUsecase.getTiemposTardaCAUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tiempos tarda centro atención',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await tiempoTardaCAUsecaseDB.saveTiempoTardaCAUsecase(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncViasAcceso(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Tiempos tarda CA ****************************

// ************************** Via acceso ****************************

  Future<void> syncViasAcceso(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await viaAccesoUsecase
        .getViasAccesoUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando vias acceso',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await viaAccesoUsecaseDB.saveViaAccesoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncAutoridadesIndigenas(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Via acceso ****************************

// ************************** AutoridadIndigena ****************************

  Future<void> syncAutoridadesIndigenas(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await autoridadIndigenaUsecase.getAutoridadesIndigenasUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando autoridades indígenas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await autoridadIndigenaUsecaseDB
            .saveAutoridadIndigenaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncCereales(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** AutoridadIndigena ****************************

// ************************** Cereal ****************************

  Future<void> syncCereales(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await cerealUsecase
        .getCerealesUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando cereales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await cerealUsecaseDB.saveCerealUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncCostosDesplazamiento(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Cereal ****************************

// ************************** CostoDesplazamiento ****************************

  Future<void> syncCostosDesplazamiento(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await costoDesplazamientoUsecase.getCostosDesplazamientoUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando costos desplazamiento',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await costoDesplazamientoUsecaseDB
            .saveCostoDesplazamientoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncDificultadesAccesoMedTradicional(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** CostoDesplazamiento ****************************

// ************************** DificultadAccesoMedTradicional ****************************

  Future<void> syncDificultadesAccesoMedTradicional(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await dificultadAccesoMedTradicionalUsecase
        .getDificultadesAccesoMedTradicionalUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando dificultades acceso médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await dificultadAccesoMedTradicionalUsecaseDB
            .saveDificultadAccesoMedTradicionalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEspecialidadesMedTradicional(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** DificultadAccesoMedTradicional ****************************

// ************************** EspecialidadMedTradicional ****************************

  Future<void> syncEspecialidadesMedTradicional(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await especialidadMedTradicionalUsecase
        .getEspecialidadesMedTradicionalUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando especialidades médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await especialidadMedTradicionalUsecaseDB
            .saveEspecialidadMedTradicionalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEspeciesAnimales(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** EspecialidadMedTradicional ****************************

// ************************** EspecieAnimal ****************************

  Future<void> syncEspeciesAnimales(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await especieAnimalUsecase.getEspeciesAnimalesUsecase(
        event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando especies animales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await especieAnimalUsecaseDB.saveEspecieAnimalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncFrutos(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** EspecieAnimal ****************************

// ************************** Fruto ****************************

  Future<void> syncFrutos(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await frutoUsecase
        .getFrutosUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando frutos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await frutoUsecaseDB.saveFrutoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncHortalizas(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Fruto ****************************

// ************************** Hortaliza ****************************

  Future<void> syncHortalizas(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await hortalizaUsecase
        .getHortalizasUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando hortalizas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await hortalizaUsecaseDB.saveHortalizaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncLeguminosas(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Hortaliza ****************************

// ************************** Leguminosa ****************************

  Future<void> syncLeguminosas(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await leguminosaUsecase
        .getLeguminosasUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando leguminosas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await leguminosaUsecaseDB.saveLeguminosaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncMediosUtilizaMedTradicional(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Leguminosa ****************************

// ************************** MedioUtilizaMedTradicional ****************************

  Future<void> syncMediosUtilizaMedTradicional(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await medioUtilizaMedTradicionalUsecase
        .getMediosUtilizaMedTradicionalUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios utiliza médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await medioUtilizaMedTradicionalUsecaseDB
            .saveMedioUtilizaMedTradicionalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncOpcionesSiNo(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** MedioUtilizaMedTradicional ****************************

// ************************** OpcionSiNo ****************************

  Future<void> syncOpcionesSiNo(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await opcionSiNoUsecase.getOpcionesSiNoUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando opciones',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await opcionSiNoUsecaseDB.saveOpcionSiNoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncResguardos(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** OpcionSiNo ****************************

// ************************** Resguardo ****************************

  Future<void> syncResguardos(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await resguardoUsecase
        .getResguardosUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando resguardos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await resguardoUsecaseDB.saveResguardoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTiemposTardaMedTradicional(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Resguardo ****************************

// ************************** TiempoTardaMedTradicional ****************************

  Future<void> syncTiemposTardaMedTradicional(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await tiempoTardaMedTradicionalUsecase
        .getTiemposTardaMedTradicionalUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tiempos tarda médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await tiempoTardaMedTradicionalUsecaseDB
            .saveTiempoTardaMedTradicionalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTuberculosPlatanos(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TiempoTardaMedTradicional ****************************

// ************************** TuberculoPlatano ****************************

  Future<void> syncTuberculosPlatanos(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await tuberculoPlatanoUsecase.getTuberculosPlatanosUsecase(
        event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tubérculos plátanos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await tuberculoPlatanoUsecaseDB
            .saveTuberculoPlatanoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncVerduras(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TuberculoPlatano ****************************

// ************************** Verdura ****************************

  Future<void> syncVerduras(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await verduraUsecase
        .getVerdurasUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando verduras',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await verduraUsecaseDB.saveVerduraUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncFactoresRiesgoVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }
// ************************** Verdura ****************************

// ************************** FactorRiesgoVivienda ****************************

  Future<void> syncFactoresRiesgoVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await factorRiesgoViviendaUsecase.getFactoresRiesgoViviendaUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando factores riesgo vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await factorRiesgoViviendaUsecaseDB
            .saveFactorRiesgoViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncIluminacionesVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** FactorRiesgoVivienda ****************************

// ************************** IluminacionVivienda ****************************

  Future<void> syncIluminacionesVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await iluminacionViviendaUsecase.getIluminacionesViviendaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando iluminaciones vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await iluminacionViviendaUsecaseDB
            .saveIluminacionViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncPisosVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** IluminacionVivienda ****************************

// ************************** PisoVivienda ****************************

  Future<void> syncPisosVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await pisoViviendaUsecase
        .getPisosViviendaUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando pisos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await pisoViviendaUsecaseDB.savePisoViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncPresenciaAnimalesVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** PisoVivienda ****************************

// ************************** PresenciaAnimalVivienda ****************************

  Future<void> syncPresenciaAnimalesVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await presenciaAnimalViviendaUsecase
        .getPresenciaAnimalesViviendaUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando presencia animales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await presenciaAnimalViviendaUsecaseDB
            .savePresenciaAnimalViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncServiciosPublicosVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** PresenciaAnimalVivienda ****************************

// ************************** ServicioPublicoVivienda ****************************

  Future<void> syncServiciosPublicosVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await servicioPublicoViviendaUsecase
        .getServiciosPublicosViviendaUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando servicios públicos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await servicioPublicoViviendaUsecaseDB
            .saveServicioPublicoViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTechosVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** ServicioPublicoVivienda ****************************

// ************************** TechoVivienda ****************************

  Future<void> syncTechosVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await techoViviendaUsecase
        .getTechosViviendaUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando techos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await techoViviendaUsecaseDB.saveTechoViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTenenciasVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TechoVivienda ****************************

// ************************** TenenciaVivienda ****************************

  Future<void> syncTenenciasVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await tenenciaViviendaUsecase.getTenenciasViviendaUsecase(
        event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tenencias vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await tenenciaViviendaUsecaseDB
            .saveTenenciaViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTiposCombustibleVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TenenciaVivienda ****************************

// ************************** TipoCombustibleVivienda ****************************

  Future<void> syncTiposCombustibleVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await tipoCombustibleViviendaUsecase.getTiposCombustibleViviendaUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos combustible vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await tipoCombustibleViviendaUsecaseDB
            .saveTipoCombustibleViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTiposSanitarioVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TipoCombustibleVivienda ****************************

// ************************** TipoSanitarioVivienda ****************************

  Future<void> syncTiposSanitarioVivienda(SyncStarted event) async {
    final completer = Completer<void>();
    final result =
        await tipoSanitarioViviendaUsecase.getTiposSanitarioViviendaUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos sanitario vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await tipoSanitarioViviendaUsecaseDB
            .saveTipoSanitarioViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTratamientosAguaVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TipoSanitarioVivienda ****************************

// ************************** TratamientoAguaVivienda ****************************

  Future<void> syncTratamientosAguaVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await tratamientoAguaViviendaUsecase.getTratamientosAguaViviendaUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tratamientos agua vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await tratamientoAguaViviendaUsecaseDB
            .saveTratamientoAguaViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncVentilacionesVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TratamientoAguaVivienda ****************************

// ************************** VentilacionesVivienda ****************************

  Future<void> syncVentilacionesVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await ventilacionViviendaUsecase.getVentilacionesViviendaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando ventilaciones vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await ventilacionViviendaUsecaseDB
            .saveVentilacionViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTiposVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** VentilacionesVivienda ****************************

// ************************** TiposVivienda ****************************

  Future<void> syncTiposVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await tipoViviendaUsecase
        .getTiposViviendaUsecase(event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await tipoViviendaUsecaseDB.saveTipoViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTiposCalendario(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TiposVivienda ****************************

// ************************** TiposCalendario ****************************

  Future<void> syncTiposCalendario(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await tipoCalendarioUsecase.getTiposCalendarioUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos calendario',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await tipoCalendarioUsecaseDB.saveTipoCalendarioUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncCursosVida(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TiposCalendario ****************************

// ************************** CursosVida ****************************

  Future<void> syncCursosVida(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await cursoVidaUsecase.getCursosVidaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando cursos vida',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await cursoVidaUsecaseDB.saveCursoVidaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEtnias(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** CursosVida ****************************

// ************************** Etnias ****************************

  Future<void> syncEtnias(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await etniaUsecase.getEtniasUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando etnias',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await etniaUsecaseDB.saveEtniaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncGeneros(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Etnias ****************************

// ************************** Generos ****************************

  Future<void> syncGeneros(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await generoUsecase.getGenerosUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando generos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await generoUsecaseDB.saveGeneroUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncGruposRiesgo(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Generos ****************************

// ************************** GruposRiesgo ****************************

  Future<void> syncGruposRiesgo(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await grupoRiesgoUsecase.getGruposRiesgoUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando grupos riesgo',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await grupoRiesgoUsecaseDB.saveGrupoRiesgoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncLenguasManeja(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** GruposRiesgo ****************************

// ************************** LenguasManeja ****************************

  Future<void> syncLenguasManeja(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await lenguaManejaUsecase.getLenguasManejaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lenguas maneja',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await lenguaManejaUsecaseDB.saveLenguaManejaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncNivelesEducativos(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** LenguasManeja ****************************

// ************************** NivelesEducativos ****************************

  Future<void> syncNivelesEducativos(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await nivelEducativoUsecase.getNivelesEducativosUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando niveles educativos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await nivelEducativoUsecaseDB.saveNivelEducativoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncNombresLenguasMaterna(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** NivelesEducativos ****************************

// ************************** NombresLenguasMaterna ****************************

  Future<void> syncNombresLenguasMaterna(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await nombreLenguaMaternaUsecase.getNombresLenguasMaternaUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando nombres lenguas maternas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await nombreLenguaMaternaUsecaseDB
            .saveNombreLenguaMaternaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncOcupaciones(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** NombresLenguasMaterna ****************************

// ************************** Ocupaciones ****************************

  Future<void> syncOcupaciones(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await ocupacionUsecase.getOcupacionesUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando ocupaciones',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await ocupacionUsecaseDB.saveOcupacionUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncParentescos(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Ocupaciones ****************************

// ************************** Parentescos ****************************

  Future<void> syncParentescos(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await parentescoUsecase.getParentescosUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando parentescos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await parentescoUsecaseDB.saveParentescoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncPueblosIndigenas(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Parentescos ****************************

// ************************** PueblosIndigenas ****************************

  Future<void> syncPueblosIndigenas(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await puebloIndigenaUsecase.getPueblosIndigenasUsecase(
        event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando pueblos indigenas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await puebloIndigenaUsecaseDB.savePuebloIndigenaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTipoRegimenes(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** PueblosIndigenas ****************************

// ************************** TipoRegimenes ****************************

  Future<void> syncTipoRegimenes(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await tiporegimenUsecase.getTipoRegimenesUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos regimenes',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await tiporegimenUsecaseDB.saveTipoRegimenUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncTiposDocumento(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TipoRegimenes ****************************

// ************************** TiposDocumento ****************************

  Future<void> syncTiposDocumento(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await tipoDocumentoUsecase.getTiposDocumentoUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos documento',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await tipoDocumentoUsecaseDB.saveTipoDocumentoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncActividadesFisicas(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** TiposDocumento ****************************

// ************************** ActividadesFisicas ****************************

  Future<void> syncActividadesFisicas(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await actividadFisicaUsecase.getActividadesFisicasUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando actividades físicas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await actividadFisicaUsecaseDB
            .saveActividadFisicaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncAlimentaciones(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** ActividadesFisicas ****************************

// ************************** Alimentaciones ****************************

  Future<void> syncAlimentaciones(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await alimentacionUsecase.getAlimentacionesUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando alimentación',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await alimentacionUsecaseDB.saveAlimentacionUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncCigarrillosDia(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** Alimentaciones ****************************

// ************************** CigarrillosDia ****************************

  Future<void> syncCigarrillosDia(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await cigarrilloDiaUsecase.getCigarrillosDiaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando número cigarrillos día',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await cigarrilloDiaUsecaseDB.saveCigarrilloDiaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncConsumosAlcohol(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** CigarrillosDia ****************************

// ************************** ConsumosAlcohol ****************************

  Future<void> syncConsumosAlcohol(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await consumoAlcoholUsecase.getConsumosAlcoholUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando consumo alcohol',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await consumoAlcoholUsecaseDB.saveConsumoAlcoholUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncCondicionesNutricionales(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** ConsumosAlcohol ****************************

// ************************** CondicionesNutricionales ****************************

  Future<void> syncCondicionesNutricionales(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await condicionNutricionalUsecase.getCondicionesNutricionalesUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando condiciones nutricionales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await condicionNutricionalUsecaseDB
            .saveCondicionNutricionalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncConductasSeguir(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** CondicionesNutricionales ****************************

// ************************** ConductasSeguir ****************************

  Future<void> syncConductasSeguir(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await conductaSeguirUsecase.getConductasSeguirUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando conductas seguir',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result =
            await conductaSeguirUsecaseDB.saveConductaSeguirUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEsquemasVacunacion(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** ConductasSeguir ****************************

// ************************** EsquemasVacunacion ****************************

  Future<void> syncEsquemasVacunacion(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await esquemaVacunacionUsecase.getEsquemasVacunacionUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando esquemas vacunacion',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await esquemaVacunacionUsecaseDB
            .saveEsquemaVacunacionUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncLugaresVacunacion(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** EsquemasVacunacion ****************************

// ************************** LugaresVacunacion ****************************

  Future<void> syncLugaresVacunacion(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await lugarVacunacionUsecase.getLugaresVacunacionUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lugares vacunacion',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await lugarVacunacionUsecaseDB
            .saveLugarVacunacionUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncMetodosPlanificacion(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** LugaresVacunacion ****************************

// ************************** MetodosPlanificacion ****************************

  Future<void> syncMetodosPlanificacion(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await metodoPlanificacionUsecase.getMetodosPlanificacionUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando metodos planificacion',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await metodoPlanificacionUsecaseDB
            .saveMetodoPlanificacionUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncNombresEnfermedades(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** MetodosPlanificacion ****************************

// ************************** NombresEnfermedades ****************************

  Future<void> syncNombresEnfermedades(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await nombreEnfermedadUsecase.getNombresEnfermedadesUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando nombres enfermedades',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await nombreEnfermedadUsecaseDB
            .saveNombreEnfermedadUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncSeguimientoEnfermedades(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** NombresEnfermedades ****************************

// ************************** SeguimientoEnfermedades ****************************

  Future<void> syncSeguimientoEnfermedades(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await seguimientoEnfermedadUsecase.getSeguimientoEnfermedadesUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando seguimiento enfermedades',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await seguimientoEnfermedadUsecaseDB
            .saveSeguimientoEnfermedadUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncServiciosSolicitados(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** SeguimientoEnfermedades ****************************

// ************************** ServiciosSolicitados ****************************

  Future<void> syncServiciosSolicitados(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await servicioSolicitadoUsecase.getServiciosSolicitadosUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando servicios solicitados',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await servicioSolicitadoUsecaseDB
            .saveServicioSolicitadoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncUltimasVecesInstSalud(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** ServiciosSolicitados ****************************

// ************************** UltimasVecesInstSalud ****************************

  Future<void> syncUltimasVecesInstSalud(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await ultimaVezInstSaludUsecase.getUltimasVecesInstSaludUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando ultima vez inst salud',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await ultimaVezInstSaludUsecaseDB
            .saveUltimaVezInstSaludUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEnfermedadesAcude(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** UltimasVecesInstSalud ****************************

// ************************** EnfermedadesAcude ****************************

  Future<void> syncEnfermedadesAcude(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await enfermedadAcudeUsecase.getEnfermedadesAcudeUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando enfermedades acude',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await enfermedadAcudeUsecaseDB
            .saveEnfermedadAcudeUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEnfermedadesTratamiento(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** EnfermedadesAcude ****************************

// ************************** EnfermedadesTratamiento ****************************

  Future<void> syncEnfermedadesTratamiento(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await enfermedadTratamientoUsecase.getEnfermedadesTratamientoUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando enfermedades tratamiento',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await enfermedadTratamientoUsecaseDB
            .saveEnfermedadTratamientoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEnfermedadesTradicionales(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** EnfermedadesTratamiento ****************************

// ************************** EnfermedadesTradicionales ****************************

  Future<void> syncEnfermedadesTradicionales(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await enfermedadTradicionalUsecase.getEnfermedadesTradicionalesUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando enfermedades tradicionales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await enfermedadTradicionalUsecaseDB
            .saveEnfermedadTradicionalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncLugaresAtencionMedico(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** EnfermedadesTradicionales ****************************

// ************************** LugaresAtencionMedico ****************************

  Future<void> syncLugaresAtencionMedico(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await lugarAtencionMedicoUsecase.getLugaresAtencionMedicoUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lugares atención médico',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await lugarAtencionMedicoUsecaseDB
            .saveLugarAtencionMedicoUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncLugaresPlantasMedicinales(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** LugaresAtencionMedico ****************************

// ************************** LugaresPlantasMedicinales ****************************

  Future<void> syncLugaresPlantasMedicinales(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await lugarPlantaMedicinalUsecase.getLugaresPlantasMedicinalesUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lugares plantas medicinales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await lugarPlantaMedicinalUsecaseDB
            .saveLugarPlantaMedicinalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncPlantasMedicinales(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** LugaresPlantasMedicinales ****************************

// ************************** PlantasMedicinales ****************************

  Future<void> syncPlantasMedicinales(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await plantaMedicinalUsecase.getPlantasMedicinalesUsecase(
        event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando plantas medicinales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await plantaMedicinalUsecaseDB
            .savePlantaMedicinalUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncReligionesProfesa(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** PlantasMedicinales ****************************

// ************************** ReligionesProfesa ****************************

  Future<void> syncReligionesProfesa(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await religionProfesaUsecase.getReligionesProfesaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando religiones profesa',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await religionProfesaUsecaseDB
            .saveReligionProfesaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncEventosCostumbresParticipa(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** ReligionesProfesa ****************************

// ************************** EventosCostumbresParticipa ****************************

  Future<void> syncEventosCostumbresParticipa(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await eventoCostumbreParticipaUsecase
        .getEventosCostumbresParticipaUsecase(
            event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando eventos costumbres participa',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await eventoCostumbreParticipaUsecaseDB
            .saveEventoCostumbreParticipaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncCostumbresPractican(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** EventosCostumbresParticipa ****************************

// ************************** CostumbresPractican ****************************

  Future<void> syncCostumbresPractican(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await costumbrePracticaUsecase.getCostumbresPracticanUsecase(
        event.user.userMetadata!['Departamento_id']);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando eventos costumbres participa',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await costumbrePracticaUsecaseDB
            .saveCostumbrePracticaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncSancionesJusticia(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** CostumbresPractican ****************************

// ************************** SancionesJusticia ****************************

  Future<void> syncSancionesJusticia(SyncStarted event) async {
    final completer = Completer<void>();

    final result = await sancionJusticiaUsecase.getSancionesJusticiaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando eventos costumbres participa',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await sancionJusticiaUsecaseDB
            .saveSancionJusticiaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncNroCuartosVivienda(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** SancionesJusticia ****************************

// ************************** NroCuartosVivienda ****************************

  Future<void> syncNroCuartosVivienda(SyncStarted event) async {
    final completer = Completer<void>();

    final result =
        await nroCuartoViviendaUsecase.getNroCuartosViviendaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando cuartos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      for (var i = 0; i < data.length; i++) {
        final result = await nroCuartoViviendaUsecaseDB
            .saveNroCuartoViviendaUsecaseDB(data[i]);
        result.fold((failure) {
          add(SyncError(failure.properties.first));
          completer.completeError(failure);
        }, (_) {});
      }

      if (!completer.isCompleted) {
        await syncFichas(event);
        completer.complete();
      }
    });

    return completer.future;
  }

// ************************** NroCuartosVivienda ****************************

// ************************** Fichas ****************************

  Future<void> syncFichas(SyncStarted event) async {
    final completer = Completer<void>();

    String userName = event.user.userMetadata!['UserName'];
    final result = await fichaUsecase.getFichasUsecase(userName);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      fichasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando fichas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (fichasTemp.isNotEmpty) {
        countRecordsFichasTemp = 0;
        await saveFichas(
          event,
          fichasTemp[countRecordsFichasTemp],
        );
      } else {
        if (!completer.isCompleted) {
          add(SyncIncrementChanged(state.syncProgressModel.copyWith(
              title: 'Sincronización completada',
              counter: state.syncProgressModel.counter + 1,
              total: state.syncProgressModel.totalAccesorias)));
          completer.complete();
        }
      }
    });

    return completer.future;
  }

  Future<void> saveFichas(
    SyncStarted event,
    FichaEntity ficha,
  ) async {
    final completer = Completer<void>();

    final result = await fichaUsecaseDB.createFichaCompletaUsecaseDB(ficha);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      countRecordsFichasTemp++;
      if (countRecordsFichasTemp >= fichasTemp.length) {
        return;
      }

      FichaEntity fichaTemp = fichasTemp[countRecordsFichasTemp];
      await saveFichas(
        event,
        fichaTemp,
      );

      if (!completer.isCompleted) {
        completer.complete();
      }
    });

    return completer.future;
  }
}
