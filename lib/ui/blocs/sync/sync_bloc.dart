// ignore_for_file: empty_catches

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
import '../../../data/models/alimentacion.dart';
import '../../../data/models/sync_progress.dart';
import '../../../domain/entities/usuario.dart';
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
import '../../../domain/usecases/cuarto_vivienda/cuarto_vivienda_exports.dart';
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
import '../../../domain/usecases/regimen/regimen_exports.dart';
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
  final RegimenUsecase regimenUsecase;
  final RegimenUsecaseDB regimenUsecaseDB;
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
  final CuartoViviendaUsecase cuartoViviendaUsecase;
  final CuartoViviendaUsecaseDB cuartoViviendaUsecaseDB;

  final FichaUsecase fichaUsecase;
  final FichaUsecaseDB fichaUsecaseDB;

  final prefs = SharedPreferencesService();

  int successfulAfiliadoInserts = 0;
  List<DificultadAccesoCAEntity> dificultadesAccesoCATemp = [];
  List<EstadoViaEntity> estadoViasTemp = [];
  List<MedioComunicacionEntity> mediosComunicacionTemp = [];
  List<MedioUtilizaCAEntity> mediosUtilizaCATemp = [];
  List<TiempoTardaCAEntity> tiemposTardaCATemp = [];
  List<ViaAccesoEntity> viasAccesoTemp = [];
  List<AutoridadIndigenaEntity> autoridadesIndigenasTemp = [];
  List<CerealEntity> cerealesTemp = [];
  List<CostoDesplazamientoEntity> costosDesplazamientoTemp = [];
  List<DificultadAccesoMedTradicionalEntity>
      dificultadesAccesoMedTradicionalTemp = [];
  List<EspecialidadMedTradicionalEntity> especialidadesMedTradicionalTemp = [];
  List<EspecieAnimalEntity> especiesAnimalesTemp = [];
  List<FrutoEntity> frutosTemp = [];
  List<HortalizaEntity> hortalizasTemp = [];
  List<LeguminosaEntity> leguminosasTemp = [];
  List<MedioUtilizaMedTradicionalEntity> mediosUtilizaMedTradicionalTemp = [];
  List<OpcionSiNoEntity> opcionesSiNoTemp = [];
  List<ResguardoEntity> resguardosTemp = [];
  List<TiempoTardaMedTradicionalEntity> tiemposTardaMedTradicionalTemp = [];
  List<TuberculoPlatanoEntity> tuberculosPlatanosTemp = [];
  List<VerduraEntity> verdurasTemp = [];
  List<FactorRiesgoViviendaEntity> factoresRiesgoViviendaTemp = [];
  List<IluminacionViviendaEntity> iluminacionesViviendaTemp = [];
  List<PisoViviendaEntity> pisosViviendaTemp = [];
  List<PresenciaAnimalViviendaEntity> presenciaAnimalesViviendaTemp = [];
  List<ServicioPublicoViviendaEntity> serviciosPublicosViviendaTemp = [];
  List<TechoViviendaEntity> techosViviendaTemp = [];
  List<TenenciaViviendaEntity> tenenciasViviendaTemp = [];
  List<TipoCombustibleViviendaEntity> tiposCombustibleViviendaTemp = [];
  List<TipoSanitarioViviendaEntity> tiposSanitarioViviendaTemp = [];
  List<TratamientoAguaViviendaEntity> tratamientosAguaViviendaTemp = [];
  List<VentilacionViviendaEntity> ventilacionesViviendaTemp = [];
  List<TipoViviendaEntity> tiposViviendaTemp = [];
  List<TipoCalendarioEntity> tiposCalendarioTemp = [];
  List<CursoVidaEntity> cursosVidaTemp = [];
  List<EtniaEntity> etniasTemp = [];
  List<GeneroEntity> generosTemp = [];
  List<GrupoRiesgoEntity> gruposRiesgoTemp = [];
  List<LenguaManejaEntity> lenguasManejaTemp = [];
  List<NivelEducativoEntity> nivelesEducativosTemp = [];
  List<NombreLenguaMaternaEntity> nombresLenguasMaternaTemp = [];
  List<OcupacionEntity> ocupacionesTemp = [];
  List<ParentescoEntity> parentescosTemp = [];
  List<PuebloIndigenaEntity> pueblosIndigenasTemp = [];
  List<RegimenEntity> regimenesTemp = [];
  List<TipoDocumentoEntity> tiposDocumentoTemp = [];
  List<ActividadFisicaEntity> actividadesFisicasTemp = [];
  List<AlimentacionEntity> alimentacionesTemp = [];
  List<CigarrilloDiaEntity> cigarrillosDiaTemp = [];
  List<ConsumoAlcoholEntity> consumosAlcoholTemp = [];
  List<CondicionNutricionalEntity> condicionesNutricionalesTemp = [];
  List<ConductaSeguirEntity> conductasSeguirTemp = [];
  List<EsquemaVacunacionEntity> esquemasVacunacionTemp = [];
  List<LugarVacunacionEntity> lugaresVacunacionTemp = [];
  List<MetodoPlanificacionEntity> metodosPlanificacionTemp = [];
  List<NombreEnfermedadEntity> nombresEnfermedadesTemp = [];
  List<SeguimientoEnfermedadEntity> seguimientoEnfermedadesTemp = [];
  List<ServicioSolicitadoEntity> serviciosSolicitadosTemp = [];
  List<UltimaVezInstSaludEntity> ultimasVecesInstSaludTemp = [];
  List<EnfermedadAcudeEntity> enfermedadesAcudeTemp = [];
  List<EnfermedadTratamientoEntity> enfermedadesTratamientoTemp = [];
  List<EnfermedadTradicionalEntity> enfermedadesTradicionalesTemp = [];
  List<LugarAtencionMedicoEntity> lugaresAtencionMedicoTemp = [];
  List<LugarPlantaMedicinalEntity> lugaresPlantasMedicinalesTemp = [];
  List<PlantaMedicinalEntity> plantasMedicinalesTemp = [];
  List<ReligionProfesaEntity> religionesProfesaTemp = [];
  List<EventoCostumbreParticipaEntity> eventosCostumbresParticipaTemp = [];
  List<CostumbrePracticaEntity> costumbresPracticanTemp = [];
  List<SancionJusticiaEntity> sancionesJusticiaTemp = [];
  List<CuartoViviendaEntity> cuartosViviendaTemp = [];
  int countRecordsDificultadAccesoTemp = 0;
  int countRecordsEstadoViasTemp = 0;
  int countRecordsMediosComunicacionTemp = 0;
  int countRecordsMediosUtilizaTemp = 0;
  int countRecordsTiemposTardaTemp = 0;
  int countRecordsViasAccesoTemp = 0;
  int countRecordsAutoridadesIndigenasTemp = 0;
  int countRecordsCerealesTemp = 0;
  int countRecordsCostosDesplazamientoTemp = 0;
  int countRecordsDificultadesAccesoMedTradicionalTemp = 0;
  int countRecordsEspecialidadesMedTradicionalTemp = 0;
  int countRecordsEspeciesAnimalesTemp = 0;
  int countRecordsFrutosTemp = 0;
  int countRecordsHortalizasTemp = 0;
  int countRecordsLeguminosasTemp = 0;
  int countRecordsMediosUtilizaMedTradicionalTemp = 0;
  int countRecordsOpcionesSiNoTemp = 0;
  int countRecordsResguardosTemp = 0;
  int countRecordsTiemposTardaMedTradicionalTemp = 0;
  int countRecordsTuberculosPlatanosTemp = 0;
  int countRecordsVerdurasTemp = 0;
  int countRecordsFactoresRiesgoViviendaTemp = 0;
  int countRecordsIluminacionesViviendaTemp = 0;
  int countRecordsPisosViviendaTemp = 0;
  int countRecordsPresenciaAnimalesViviendaTemp = 0;
  int countRecordsServiciosPublicosViviendaTemp = 0;
  int countRecordsTechosViviendaTemp = 0;
  int countRecordsTenenciasViviendaTemp = 0;
  int countRecordsTiposCombustibleViviendaTemp = 0;
  int countRecordsTiposSanitarioViviendaTemp = 0;
  int countRecordsTratamientosAguaViviendaTemp = 0;
  int countRecordsVentilacionesViviendaTemp = 0;
  int countRecordsTiposViviendaTemp = 0;
  int countRecordsTiposCalendarioTemp = 0;
  int countRecordsCursosVidaTemp = 0;
  int countRecordsEtniasTemp = 0;
  int countRecordsGenerosTemp = 0;
  int countRecordsGruposRiesgoTemp = 0;
  int countRecordsLenguasManejaTemp = 0;
  int countRecordsNivelesEducativosTemp = 0;
  int countRecordsNombresLenguasMaternaTemp = 0;
  int countRecordsOcupacionesTemp = 0;
  int countRecordsParentescosTemp = 0;
  int countRecordsPueblosIndigenasTemp = 0;
  int countRecordsRegimenesTemp = 0;
  int countRecordsTiposDocumentoTemp = 0;
  int countRecordsActividadesFisicasTemp = 0;
  int countRecordsAlimentacionesTemp = 0;
  int countRecordsCigarrillosDiaTemp = 0;
  int countRecordsConsumosAlcoholTemp = 0;
  int countRecordsCondicionesNutricionalesTemp = 0;
  int countRecordsConductasSeguirTemp = 0;
  int countRecordsEsquemasVacunacionTemp = 0;
  int countRecordsLugaresVacunacionTemp = 0;
  int countRecordsMetodosPlanificacionTemp = 0;
  int countRecordsNombresEnfermedadesTemp = 0;
  int countRecordsSeguimientoEnfermedadesTemp = 0;
  int countRecordsServiciosSolicitadosTemp = 0;
  int countRecordsUltimasVecesInstSaludTemp = 0;
  int countRecordsEnfermedadesAcudeTemp = 0;
  int countRecordsEnfermedadesTratamientoTemp = 0;
  int countRecordsEnfermedadesTradicionalesTemp = 0;
  int countRecordsLugaresAtencionMedicoTemp = 0;
  int countRecordsLugaresPlantasMedicinalesTemp = 0;
  int countRecordsPlantasMedicinalesTemp = 0;
  int countRecordsReligionesProfesaTemp = 0;
  int countRecordsEventosCostumbresParticipaTemp = 0;
  int countRecordsCostumbresPracticanTemp = 0;
  int countRecordsSancionesJusticiaTemp = 0;
  int countRecordsCuartosViviendaTemp = 0;
  int countRecordsFichasTemp = 0;

  List<FichaEntity> fichasTemp = [];

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
    required this.regimenUsecase,
    required this.regimenUsecaseDB,
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
    required this.cuartoViviendaUsecase,
    required this.cuartoViviendaUsecaseDB,
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
        await syncFicha(event);
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

// ************************** Ficha ****************************
  Future<void> syncFicha(
    SyncStarted event,
  ) async {
    final result = await fichaUsecase.createFichaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
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
          add(SyncError(
            decodedResp['message'],
          ));
        }
        // if (resp.statusCode == 200 || resp.statusCode == 201) {
        //   add(SyncIncrementChanged(state.syncProgressModel.copyWith(
        //     title: decodedResp['Description'],
        //   )));
        // } else {
        //   add(const SyncError('Excepción no controlada'));
        // }
      }
    });
  }
// ************************** Ficha ****************************

// ************************** Afiliados ****************************
  Future<void> syncAfiliados(SyncStarted event) async {
    int mpioId = event.usuario.municipioId!;
    int limit = 5000;
    List<dynamic> afiliadosMap = [];
    List<Map<String, dynamic>> combinedList = [];

    final requestUrl =
        Uri.parse('${AppConfig.syncPublica}/afiliados/$mpioId/$limit');

    try {
      final reqRes = await http.get(requestUrl);

      if (reqRes.statusCode == 200) {
        final decodedReq = json.decode(reqRes.body);
        final int totalRecords = decodedReq['totalRecords'];
        final int loopValue = decodedReq['loopValue'];

        for (var i = 0; i < loopValue; i++) {
          final afiliadosUrl = Uri.parse(
              '${AppConfig.syncPublica}/afiliados/afiliadosbympio?limit=$limit&page=$i&mpioId=$mpioId');
          final afiliadosRes = await http.get(afiliadosUrl);
          if (afiliadosRes.statusCode == 200) {
            final decodeReq = json.decode(afiliadosRes.body);
            afiliadosMap.addAll(decodeReq);
          } else {
            add(const SyncError('Excepción no controlada'));
          }

          final syncProgressModel = state.syncProgressModel.copyWith(
            title: 'Sincronizando afiliados',
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

        final result = AfiliadoResponseModel.fromJson(afiliadoResp);

        await supabase.from('afiliados').insert(result.resultado);
      } else {
        add(const SyncError('Excepción no controlada'));
      }
    } on PostgrestException catch (error) {
      add(SyncError(error.message));
    } on SocketException catch (e) {
      add(SyncError(e.toString()));
    }
  }

  Future<void> saveAfiliados(
      SyncStarted event, AfiliadoResponseModel afiliadosRes) async {
    try {
      for (int i = 0; i < afiliadosRes.resultado.length; i++) {
        final afiliado = afiliadosRes.resultado[i];

        // Insert each afiliado record
        final response =
            await supabase.from('Afiliado').insert(afiliado.toJson());

        if (response.error == null) {
          successfulAfiliadoInserts += 1;
        } else {
          throw Exception(
              'Failed to insert afiliado: ${response.error?.message}');
        }

        // Optionally, update sync progress here if needed
        final syncProgressModel = state.syncProgressModel.copyWith(
          title: 'Sincronizando afiliados',
          counter: i + 1, // Increment counter for each successful insert
          percent: calculatePercent(i + 1, afiliadosRes.resultado.length),
        );

        add(Downloading(syncProgressModel));
      }

      add(Downloading(state.syncProgressModel.copyWith(
        title: 'Descargando accesorias',
      )));
    } catch (e) {}
  }

  int calculatePercent(int counter, int total) {
    final percent = ((counter / total) * 100).toInt();

    return percent;
  }

// ************************** Afiliados ****************************

// ************************** Dificultades acceso CA ****************************

  Future<void> syncDificultadesAccesoCA(SyncStarted event) async {
    final result =
        await dificultadAccesoCAUsecase.getDificultadesAccesoCAUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      dificultadesAccesoCATemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando dificultades acceso',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (dificultadesAccesoCATemp.isNotEmpty) {
        countRecordsDificultadAccesoTemp = 0;
        await saveDificultadAccesoCA(
          event,
          dificultadesAccesoCATemp[countRecordsDificultadAccesoTemp],
        );
      } else {}
    });
  }

  Future<void> saveDificultadAccesoCA(
    SyncStarted event,
    DificultadAccesoCAEntity dificultadAccesoCA,
  ) async {
    final result = await dificultadAccesoCAUsecaseDB
        .saveDificultadAccesoCAUsecase(dificultadAccesoCA);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsDificultadAccesoTemp++;
      if (countRecordsDificultadAccesoTemp >= dificultadesAccesoCATemp.length) {
        return;
      }

      DificultadAccesoCAEntity dificultadAccesoCATemp =
          dificultadesAccesoCATemp[countRecordsDificultadAccesoTemp];

      await saveDificultadAccesoCA(
        event,
        dificultadAccesoCATemp,
      );
    });
  }

// ************************** Dificultades acceso CA ****************************
// ************************** Estado Vias ****************************

  Future<void> syncEstadoVias(SyncStarted event) async {
    final result = await estadoViaUsecase.getEstadoViasUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      estadoViasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando estados vías',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (estadoViasTemp.isNotEmpty) {
        countRecordsEstadoViasTemp = 0;
        await saveEstadoVia(
          event,
          estadoViasTemp[countRecordsEstadoViasTemp],
        );
      } else {}
    });
  }

  Future<void> saveEstadoVia(
    SyncStarted event,
    EstadoViaEntity estadoVia,
  ) async {
    final result = await estadoViaUsecaseDB.saveEstadoViaUsecase(estadoVia);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEstadoViasTemp++;
      if (countRecordsEstadoViasTemp >= estadoViasTemp.length) {
        return;
      }

      EstadoViaEntity estadoViaTemp =
          estadoViasTemp[countRecordsEstadoViasTemp];

      await saveEstadoVia(
        event,
        estadoViaTemp,
      );
    });
  }

// ************************** Estado Vias ****************************

// ************************** Medios comunicacion ****************************

  Future<void> syncMediosComunicacion(SyncStarted event) async {
    final result = await medioComunicacionUsecase
        .getMediosComunicacionUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      mediosComunicacionTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios comunicación',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (mediosComunicacionTemp.isNotEmpty) {
        countRecordsMediosComunicacionTemp = 0;
        await saveMedioComunicacion(
          event,
          mediosComunicacionTemp[countRecordsMediosComunicacionTemp],
        );
      } else {}
    });
  }

  Future<void> saveMedioComunicacion(
    SyncStarted event,
    MedioComunicacionEntity medioComunicacion,
  ) async {
    final result = await medioComunicacionUsecaseDB
        .saveMedioComunicacionUsecase(medioComunicacion);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsMediosComunicacionTemp++;
      if (countRecordsMediosComunicacionTemp >= mediosComunicacionTemp.length) {
        return;
      }

      MedioComunicacionEntity medioComunicacionTemp =
          mediosComunicacionTemp[countRecordsMediosComunicacionTemp];

      await saveMedioComunicacion(
        event,
        medioComunicacionTemp,
      );
    });
  }

// ************************** Medios comunicacion ****************************

// ************************** Medios utiliza CA ****************************

  Future<void> syncMediosUtilizaCA(SyncStarted event) async {
    final result = await medioUtilizaCAUsecase
        .getMediosUtilizaCAUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      mediosUtilizaCATemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios utiliza centro atención',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (mediosUtilizaCATemp.isNotEmpty) {
        countRecordsMediosUtilizaTemp = 0;
        await saveMedioUtilizaCA(
          event,
          mediosUtilizaCATemp[countRecordsMediosUtilizaTemp],
        );
      } else {}
    });
  }

  Future<void> saveMedioUtilizaCA(
    SyncStarted event,
    MedioUtilizaCAEntity medioUtilizaCA,
  ) async {
    final result =
        await medioUtilizaCAUsecaseDB.saveMedioUtilizaCAUsecase(medioUtilizaCA);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsMediosUtilizaTemp++;
      if (countRecordsMediosUtilizaTemp >= mediosUtilizaCATemp.length) {
        return;
      }

      MedioUtilizaCAEntity medioUtilizaCATemp =
          mediosUtilizaCATemp[countRecordsMediosUtilizaTemp];

      await saveMedioUtilizaCA(
        event,
        medioUtilizaCATemp,
      );
    });
  }

// ************************** Medios utiliza CA ****************************

// ************************** Tiempos tarda CA ****************************

  Future<void> syncTiemposTardaCA(SyncStarted event) async {
    final result = await tiempoTardaCAUsecase.getTiemposTardaCAUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiemposTardaCATemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tiempos tarda centro atención',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tiemposTardaCATemp.isNotEmpty) {
        countRecordsTiemposTardaTemp = 0;
        await saveTiemposTardaCA(
          event,
          tiemposTardaCATemp[countRecordsTiemposTardaTemp],
        );
      } else {}
    });
  }

  Future<void> saveTiemposTardaCA(
    SyncStarted event,
    TiempoTardaCAEntity tiempoTardaCA,
  ) async {
    final result =
        await tiempoTardaCAUsecaseDB.saveTiempoTardaCAUsecase(tiempoTardaCA);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTiemposTardaTemp++;
      if (countRecordsTiemposTardaTemp >= tiemposTardaCATemp.length) {
        return;
      }

      TiempoTardaCAEntity tiempoTardaCATemp =
          tiemposTardaCATemp[countRecordsTiemposTardaTemp];

      await saveTiemposTardaCA(
        event,
        tiempoTardaCATemp,
      );
    });
  }

// ************************** Tiempos tarda CA ****************************

// ************************** Via acceso ****************************

  Future<void> syncViasAcceso(SyncStarted event) async {
    final result = await viaAccesoUsecase
        .getViasAccesoUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      viasAccesoTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando vias acceso',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (viasAccesoTemp.isNotEmpty) {
        countRecordsViasAccesoTemp = 0;
        await saveViaAcceso(
          event,
          viasAccesoTemp[countRecordsViasAccesoTemp],
        );
      } else {}
    });
  }

  Future<void> saveViaAcceso(
    SyncStarted event,
    ViaAccesoEntity viaAcceso,
  ) async {
    final result = await viaAccesoUsecaseDB.saveViaAccesoUsecaseDB(viaAcceso);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsViasAccesoTemp++;
      if (countRecordsViasAccesoTemp >= viasAccesoTemp.length) {
        return;
      }

      ViaAccesoEntity viaAccesoTemp =
          viasAccesoTemp[countRecordsViasAccesoTemp];

      await saveViaAcceso(
        event,
        viaAccesoTemp,
      );
    });
  }

// ************************** Via acceso ****************************

// ************************** AutoridadIndigena ****************************

  Future<void> syncAutoridadesIndigenas(SyncStarted event) async {
    final result = await autoridadIndigenaUsecase
        .getAutoridadesIndigenasUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      autoridadesIndigenasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando autoridades indígenas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (autoridadesIndigenasTemp.isNotEmpty) {
        countRecordsAutoridadesIndigenasTemp = 0;
        await saveAutoridadIndigena(
          event,
          autoridadesIndigenasTemp[countRecordsAutoridadesIndigenasTemp],
        );
      } else {}
    });
  }

  Future<void> saveAutoridadIndigena(
    SyncStarted event,
    AutoridadIndigenaEntity autoridadIndigena,
  ) async {
    final result = await autoridadIndigenaUsecaseDB
        .saveAutoridadIndigenaUsecaseDB(autoridadIndigena);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsAutoridadesIndigenasTemp++;
      if (countRecordsAutoridadesIndigenasTemp >=
          autoridadesIndigenasTemp.length) {
        return;
      }

      AutoridadIndigenaEntity autoridadIndigenaTemp =
          autoridadesIndigenasTemp[countRecordsAutoridadesIndigenasTemp];

      await saveAutoridadIndigena(
        event,
        autoridadIndigenaTemp,
      );
    });
  }

// ************************** AutoridadIndigena ****************************

// ************************** Cereal ****************************

  Future<void> syncCereales(SyncStarted event) async {
    final result =
        await cerealUsecase.getCerealesUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      cerealesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando cereales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (cerealesTemp.isNotEmpty) {
        countRecordsCerealesTemp = 0;
        await saveCereal(
          event,
          cerealesTemp[countRecordsCerealesTemp],
        );
      } else {}
    });
  }

  Future<void> saveCereal(
    SyncStarted event,
    CerealEntity cereal,
  ) async {
    final result = await cerealUsecaseDB.saveCerealUsecaseDB(cereal);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsCerealesTemp++;
      if (countRecordsCerealesTemp >= cerealesTemp.length) {
        return;
      }

      CerealEntity cerealTemp = cerealesTemp[countRecordsCerealesTemp];

      await saveCereal(
        event,
        cerealTemp,
      );
    });
  }

// ************************** Cereal ****************************

// ************************** CostoDesplazamiento ****************************

  Future<void> syncCostosDesplazamiento(SyncStarted event) async {
    final result =
        await costoDesplazamientoUsecase.getCostosDesplazamientoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      costosDesplazamientoTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando costos desplazamiento',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (costosDesplazamientoTemp.isNotEmpty) {
        countRecordsCostosDesplazamientoTemp = 0;
        await saveCostoDesplazamiento(
          event,
          costosDesplazamientoTemp[countRecordsCostosDesplazamientoTemp],
        );
      } else {}
    });
  }

  Future<void> saveCostoDesplazamiento(
    SyncStarted event,
    CostoDesplazamientoEntity costoDesplazamiento,
  ) async {
    final result = await costoDesplazamientoUsecaseDB
        .saveCostoDesplazamientoUsecaseDB(costoDesplazamiento);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsCostosDesplazamientoTemp++;
      if (countRecordsCostosDesplazamientoTemp >=
          costosDesplazamientoTemp.length) {
        return;
      }

      CostoDesplazamientoEntity costoDesplazamientoTemp =
          costosDesplazamientoTemp[countRecordsCostosDesplazamientoTemp];

      await saveCostoDesplazamiento(
        event,
        costoDesplazamientoTemp,
      );
    });
  }

// ************************** CostoDesplazamiento ****************************

// ************************** DificultadAccesoMedTradicional ****************************

  Future<void> syncDificultadesAccesoMedTradicional(SyncStarted event) async {
    final result = await dificultadAccesoMedTradicionalUsecase
        .getDificultadesAccesoMedTradicionalUsecase(
            event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      dificultadesAccesoMedTradicionalTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando dificultades acceso médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (dificultadesAccesoMedTradicionalTemp.isNotEmpty) {
        countRecordsDificultadesAccesoMedTradicionalTemp = 0;
        await saveDificultadAccesoMedTradicional(
          event,
          dificultadesAccesoMedTradicionalTemp[
              countRecordsDificultadesAccesoMedTradicionalTemp],
        );
      } else {}
    });
  }

  Future<void> saveDificultadAccesoMedTradicional(
    SyncStarted event,
    DificultadAccesoMedTradicionalEntity dificultadAccesoMedTradicional,
  ) async {
    final result = await dificultadAccesoMedTradicionalUsecaseDB
        .saveDificultadAccesoMedTradicionalUsecaseDB(
            dificultadAccesoMedTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsDificultadesAccesoMedTradicionalTemp++;
      if (countRecordsDificultadesAccesoMedTradicionalTemp >=
          dificultadesAccesoMedTradicionalTemp.length) {
        return;
      }

      DificultadAccesoMedTradicionalEntity dificultadAccesoMedTradicionalTemp =
          dificultadesAccesoMedTradicionalTemp[
              countRecordsDificultadesAccesoMedTradicionalTemp];

      await saveDificultadAccesoMedTradicional(
        event,
        dificultadAccesoMedTradicionalTemp,
      );
    });
  }

// ************************** DificultadAccesoMedTradicional ****************************

// ************************** EspecialidadMedTradicional ****************************

  Future<void> syncEspecialidadesMedTradicional(SyncStarted event) async {
    final result = await especialidadMedTradicionalUsecase
        .getEspecialidadesMedTradicionalUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      especialidadesMedTradicionalTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando especialidades médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (especialidadesMedTradicionalTemp.isNotEmpty) {
        countRecordsEspecialidadesMedTradicionalTemp = 0;
        await saveEspecialidadMedTradicional(
          event,
          especialidadesMedTradicionalTemp[
              countRecordsEspecialidadesMedTradicionalTemp],
        );
      } else {}
    });
  }

  Future<void> saveEspecialidadMedTradicional(
    SyncStarted event,
    EspecialidadMedTradicionalEntity especialidadMedTradicional,
  ) async {
    final result = await especialidadMedTradicionalUsecaseDB
        .saveEspecialidadMedTradicionalUsecaseDB(especialidadMedTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEspecialidadesMedTradicionalTemp++;
      if (countRecordsEspecialidadesMedTradicionalTemp >=
          especialidadesMedTradicionalTemp.length) {
        return;
      }

      EspecialidadMedTradicionalEntity e = especialidadesMedTradicionalTemp[
          countRecordsEspecialidadesMedTradicionalTemp];

      await saveEspecialidadMedTradicional(
        event,
        e,
      );
    });
  }

// ************************** EspecialidadMedTradicional ****************************

// ************************** EspecieAnimal ****************************

  Future<void> syncEspeciesAnimales(SyncStarted event) async {
    final result = await especieAnimalUsecase
        .getEspeciesAnimalesUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      especiesAnimalesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando especies animales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (especiesAnimalesTemp.isNotEmpty) {
        countRecordsEspeciesAnimalesTemp = 0;
        await saveEspecieAnimal(
          event,
          especiesAnimalesTemp[countRecordsEspeciesAnimalesTemp],
        );
      } else {}
    });
  }

  Future<void> saveEspecieAnimal(
    SyncStarted event,
    EspecieAnimalEntity especieAnimal,
  ) async {
    final result =
        await especieAnimalUsecaseDB.saveEspecieAnimalUsecaseDB(especieAnimal);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEspeciesAnimalesTemp++;
      if (countRecordsEspeciesAnimalesTemp >= especiesAnimalesTemp.length) {
        return;
      }

      EspecieAnimalEntity especieAnimalTemp =
          especiesAnimalesTemp[countRecordsEspeciesAnimalesTemp];

      await saveEspecieAnimal(
        event,
        especieAnimalTemp,
      );
    });
  }

// ************************** EspecieAnimal ****************************

// ************************** Fruto ****************************

  Future<void> syncFrutos(SyncStarted event) async {
    final result =
        await frutoUsecase.getFrutosUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      frutosTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando frutos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (frutosTemp.isNotEmpty) {
        countRecordsFrutosTemp = 0;
        await saveFruto(
          event,
          frutosTemp[countRecordsFrutosTemp],
        );
      } else {}
    });
  }

  Future<void> saveFruto(
    SyncStarted event,
    FrutoEntity fruto,
  ) async {
    final result = await frutoUsecaseDB.saveFrutoUsecaseDB(fruto);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsFrutosTemp++;
      if (countRecordsFrutosTemp >= frutosTemp.length) {
        return;
      }

      FrutoEntity frutoTemp = frutosTemp[countRecordsFrutosTemp];

      await saveFruto(
        event,
        frutoTemp,
      );
    });
  }

// ************************** Fruto ****************************

// ************************** Hortaliza ****************************

  Future<void> syncHortalizas(SyncStarted event) async {
    final result = await hortalizaUsecase
        .getHortalizasUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      hortalizasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando hortalizas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (hortalizasTemp.isNotEmpty) {
        countRecordsHortalizasTemp = 0;
        await saveHortaliza(
          event,
          hortalizasTemp[countRecordsHortalizasTemp],
        );
      } else {}
    });
  }

  Future<void> saveHortaliza(
    SyncStarted event,
    HortalizaEntity hortaliza,
  ) async {
    final result = await hortalizaUsecaseDB.saveHortalizaUsecaseDB(hortaliza);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsHortalizasTemp++;
      if (countRecordsHortalizasTemp >= hortalizasTemp.length) {
        return;
      }

      HortalizaEntity hortalizaTemp =
          hortalizasTemp[countRecordsHortalizasTemp];

      await saveHortaliza(
        event,
        hortalizaTemp,
      );
    });
  }

// ************************** Hortaliza ****************************

// ************************** Leguminosa ****************************

  Future<void> syncLeguminosas(SyncStarted event) async {
    final result = await leguminosaUsecase
        .getLeguminosasUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      leguminosasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando leguminosas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (leguminosasTemp.isNotEmpty) {
        countRecordsLeguminosasTemp = 0;
        await saveLeguminosa(
          event,
          leguminosasTemp[countRecordsLeguminosasTemp],
        );
      } else {}
    });
  }

  Future<void> saveLeguminosa(
    SyncStarted event,
    LeguminosaEntity leguminosa,
  ) async {
    final result =
        await leguminosaUsecaseDB.saveLeguminosaUsecaseDB(leguminosa);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsLeguminosasTemp++;
      if (countRecordsLeguminosasTemp >= leguminosasTemp.length) {
        return;
      }

      LeguminosaEntity leguminosaTemp =
          leguminosasTemp[countRecordsLeguminosasTemp];

      await saveLeguminosa(
        event,
        leguminosaTemp,
      );
    });
  }

// ************************** Leguminosa ****************************

// ************************** MedioUtilizaMedTradicional ****************************

  Future<void> syncMediosUtilizaMedTradicional(SyncStarted event) async {
    final result = await medioUtilizaMedTradicionalUsecase
        .getMediosUtilizaMedTradicionalUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      mediosUtilizaMedTradicionalTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios utiliza médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (mediosUtilizaMedTradicionalTemp.isNotEmpty) {
        countRecordsMediosUtilizaMedTradicionalTemp = 0;
        await saveMedioUtilizaMedTradicional(
          event,
          mediosUtilizaMedTradicionalTemp[
              countRecordsMediosUtilizaMedTradicionalTemp],
        );
      } else {}
    });
  }

  Future<void> saveMedioUtilizaMedTradicional(
    SyncStarted event,
    MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicional,
  ) async {
    final result = await medioUtilizaMedTradicionalUsecaseDB
        .saveMedioUtilizaMedTradicionalUsecaseDB(medioUtilizaMedTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsMediosUtilizaMedTradicionalTemp++;
      if (countRecordsMediosUtilizaMedTradicionalTemp >=
          mediosUtilizaMedTradicionalTemp.length) {
        return;
      }

      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicionalTemp =
          mediosUtilizaMedTradicionalTemp[
              countRecordsMediosUtilizaMedTradicionalTemp];

      await saveMedioUtilizaMedTradicional(
        event,
        medioUtilizaMedTradicionalTemp,
      );
    });
  }

// ************************** MedioUtilizaMedTradicional ****************************

// ************************** OpcionSiNo ****************************

  Future<void> syncOpcionesSiNo(SyncStarted event) async {
    final result = await opcionSiNoUsecase.getOpcionesSiNoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      opcionesSiNoTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando opciones',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (opcionesSiNoTemp.isNotEmpty) {
        countRecordsOpcionesSiNoTemp = 0;
        await saveOpcionSiNo(
          event,
          opcionesSiNoTemp[countRecordsOpcionesSiNoTemp],
        );
      } else {}
    });
  }

  Future<void> saveOpcionSiNo(
    SyncStarted event,
    OpcionSiNoEntity opcionSiNo,
  ) async {
    final result =
        await opcionSiNoUsecaseDB.saveOpcionSiNoUsecaseDB(opcionSiNo);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsOpcionesSiNoTemp++;
      if (countRecordsOpcionesSiNoTemp >= opcionesSiNoTemp.length) {
        return;
      }

      OpcionSiNoEntity opcionSiNoTemp =
          opcionesSiNoTemp[countRecordsOpcionesSiNoTemp];

      await saveOpcionSiNo(
        event,
        opcionSiNoTemp,
      );
    });
  }

// ************************** OpcionSiNo ****************************

// ************************** Resguardo ****************************

  Future<void> syncResguardos(SyncStarted event) async {
    final result = await resguardoUsecase
        .getResguardosUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      resguardosTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando resguardos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (resguardosTemp.isNotEmpty) {
        countRecordsResguardosTemp = 0;
        await saveResguardo(
          event,
          resguardosTemp[countRecordsResguardosTemp],
        );
      } else {}
    });
  }

  Future<void> saveResguardo(
    SyncStarted event,
    ResguardoEntity resguardo,
  ) async {
    final result = await resguardoUsecaseDB.saveResguardoUsecaseDB(resguardo);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsResguardosTemp++;
      if (countRecordsResguardosTemp >= resguardosTemp.length) {
        return;
      }

      ResguardoEntity resguardoTemp =
          resguardosTemp[countRecordsResguardosTemp];

      await saveResguardo(
        event,
        resguardoTemp,
      );
    });
  }

// ************************** Resguardo ****************************

// ************************** TiempoTardaMedTradicional ****************************

  Future<void> syncTiemposTardaMedTradicional(SyncStarted event) async {
    final result = await tiempoTardaMedTradicionalUsecase
        .getTiemposTardaMedTradicionalUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiemposTardaMedTradicionalTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tiempos tarda médico tradicional',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tiemposTardaMedTradicionalTemp.isNotEmpty) {
        countRecordsTiemposTardaMedTradicionalTemp = 0;
        await saveTiempoTardaMedTradicional(
          event,
          tiemposTardaMedTradicionalTemp[
              countRecordsTiemposTardaMedTradicionalTemp],
        );
      } else {}
    });
  }

  Future<void> saveTiempoTardaMedTradicional(
    SyncStarted event,
    TiempoTardaMedTradicionalEntity tiempoTardaMedTradicional,
  ) async {
    final result = await tiempoTardaMedTradicionalUsecaseDB
        .saveTiempoTardaMedTradicionalUsecaseDB(tiempoTardaMedTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTiemposTardaMedTradicionalTemp++;
      if (countRecordsTiemposTardaMedTradicionalTemp >=
          tiemposTardaMedTradicionalTemp.length) {
        return;
      }

      TiempoTardaMedTradicionalEntity tiempoTardaMedTradicionalTemp =
          tiemposTardaMedTradicionalTemp[
              countRecordsTiemposTardaMedTradicionalTemp];

      await saveTiempoTardaMedTradicional(
        event,
        tiempoTardaMedTradicionalTemp,
      );
    });
  }

// ************************** TiempoTardaMedTradicional ****************************

// ************************** TuberculoPlatano ****************************

  Future<void> syncTuberculosPlatanos(SyncStarted event) async {
    final result = await tuberculoPlatanoUsecase
        .getTuberculosPlatanosUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tuberculosPlatanosTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tubérculos plátanos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tuberculosPlatanosTemp.isNotEmpty) {
        countRecordsTuberculosPlatanosTemp = 0;
        await saveTuberculoPlatano(
          event,
          tuberculosPlatanosTemp[countRecordsTuberculosPlatanosTemp],
        );
      } else {}
    });
  }

  Future<void> saveTuberculoPlatano(
    SyncStarted event,
    TuberculoPlatanoEntity tuberculoPlatano,
  ) async {
    final result = await tuberculoPlatanoUsecaseDB
        .saveTuberculoPlatanoUsecaseDB(tuberculoPlatano);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTuberculosPlatanosTemp++;
      if (countRecordsTuberculosPlatanosTemp >= tuberculosPlatanosTemp.length) {
        return;
      }

      TuberculoPlatanoEntity tuberculoPlatanoTemp =
          tuberculosPlatanosTemp[countRecordsTuberculosPlatanosTemp];

      await saveTuberculoPlatano(
        event,
        tuberculoPlatanoTemp,
      );
    });
  }

// ************************** TuberculoPlatano ****************************

// ************************** Verdura ****************************

  Future<void> syncVerduras(SyncStarted event) async {
    final result =
        await verduraUsecase.getVerdurasUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      verdurasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando verduras',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (verdurasTemp.isNotEmpty) {
        countRecordsVerdurasTemp = 0;
        await saveVerdura(
          event,
          verdurasTemp[countRecordsVerdurasTemp],
        );
      } else {}
    });
  }

  Future<void> saveVerdura(
    SyncStarted event,
    VerduraEntity verdura,
  ) async {
    final result = await verduraUsecaseDB.saveVerduraUsecaseDB(verdura);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsVerdurasTemp++;
      if (countRecordsVerdurasTemp >= verdurasTemp.length) {
        return;
      }

      VerduraEntity verduraTemp = verdurasTemp[countRecordsVerdurasTemp];

      await saveVerdura(
        event,
        verduraTemp,
      );
    });
  }

// ************************** Verdura ****************************

// ************************** FactorRiesgoVivienda ****************************

  Future<void> syncFactoresRiesgoVivienda(SyncStarted event) async {
    final result = await factorRiesgoViviendaUsecase
        .getFactoresRiesgoViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      factoresRiesgoViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando factores riesgo vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (factoresRiesgoViviendaTemp.isNotEmpty) {
        countRecordsFactoresRiesgoViviendaTemp = 0;
        await saveFactorRiesgoVivienda(
          event,
          factoresRiesgoViviendaTemp[countRecordsFactoresRiesgoViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveFactorRiesgoVivienda(
    SyncStarted event,
    FactorRiesgoViviendaEntity factorRiesgoVivienda,
  ) async {
    final result = await factorRiesgoViviendaUsecaseDB
        .saveFactorRiesgoViviendaUsecaseDB(factorRiesgoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsFactoresRiesgoViviendaTemp++;
      if (countRecordsFactoresRiesgoViviendaTemp >=
          factoresRiesgoViviendaTemp.length) {
        return;
      }

      FactorRiesgoViviendaEntity factorRiesgoViviendaTemp =
          factoresRiesgoViviendaTemp[countRecordsFactoresRiesgoViviendaTemp];

      await saveFactorRiesgoVivienda(
        event,
        factorRiesgoViviendaTemp,
      );
    });
  }

// ************************** FactorRiesgoVivienda ****************************

// ************************** IluminacionVivienda ****************************

  Future<void> syncIluminacionesVivienda(SyncStarted event) async {
    final result =
        await iluminacionViviendaUsecase.getIluminacionesViviendaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      iluminacionesViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando iluminaciones vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (iluminacionesViviendaTemp.isNotEmpty) {
        countRecordsIluminacionesViviendaTemp = 0;
        await saveIluminacionVivienda(
          event,
          iluminacionesViviendaTemp[countRecordsIluminacionesViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveIluminacionVivienda(
    SyncStarted event,
    IluminacionViviendaEntity iluminacionVivienda,
  ) async {
    final result = await iluminacionViviendaUsecaseDB
        .saveIluminacionViviendaUsecaseDB(iluminacionVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsIluminacionesViviendaTemp++;
      if (countRecordsIluminacionesViviendaTemp >=
          iluminacionesViviendaTemp.length) {
        return;
      }

      IluminacionViviendaEntity iluminacionViviendaTemp =
          iluminacionesViviendaTemp[countRecordsIluminacionesViviendaTemp];

      await saveIluminacionVivienda(
        event,
        iluminacionViviendaTemp,
      );
    });
  }

// ************************** IluminacionVivienda ****************************

// ************************** PisoVivienda ****************************

  Future<void> syncPisosVivienda(SyncStarted event) async {
    final result = await pisoViviendaUsecase
        .getPisosViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      pisosViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando pisos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (pisosViviendaTemp.isNotEmpty) {
        countRecordsPisosViviendaTemp = 0;
        await savePisoVivienda(
          event,
          pisosViviendaTemp[countRecordsPisosViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> savePisoVivienda(
    SyncStarted event,
    PisoViviendaEntity pisoVivienda,
  ) async {
    final result =
        await pisoViviendaUsecaseDB.savePisoViviendaUsecaseDB(pisoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsPisosViviendaTemp++;
      if (countRecordsPisosViviendaTemp >= pisosViviendaTemp.length) {
        return;
      }

      PisoViviendaEntity pisoViviendaTemp =
          pisosViviendaTemp[countRecordsPisosViviendaTemp];

      await savePisoVivienda(
        event,
        pisoViviendaTemp,
      );
    });
  }

// ************************** PisoVivienda ****************************

// ************************** PresenciaAnimalVivienda ****************************

  Future<void> syncPresenciaAnimalesVivienda(SyncStarted event) async {
    final result = await presenciaAnimalViviendaUsecase
        .getPresenciaAnimalesViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      presenciaAnimalesViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando presencia animales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (presenciaAnimalesViviendaTemp.isNotEmpty) {
        countRecordsPresenciaAnimalesViviendaTemp = 0;
        await savePresenciaAnimalVivienda(
          event,
          presenciaAnimalesViviendaTemp[
              countRecordsPresenciaAnimalesViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> savePresenciaAnimalVivienda(
    SyncStarted event,
    PresenciaAnimalViviendaEntity presenciaAnimalVivienda,
  ) async {
    final result = await presenciaAnimalViviendaUsecaseDB
        .savePresenciaAnimalViviendaUsecaseDB(presenciaAnimalVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsPresenciaAnimalesViviendaTemp++;
      if (countRecordsPresenciaAnimalesViviendaTemp >=
          presenciaAnimalesViviendaTemp.length) {
        return;
      }

      PresenciaAnimalViviendaEntity presenciaAnimalViviendaTemp =
          presenciaAnimalesViviendaTemp[
              countRecordsPresenciaAnimalesViviendaTemp];

      await savePresenciaAnimalVivienda(
        event,
        presenciaAnimalViviendaTemp,
      );
    });
  }

// ************************** PresenciaAnimalVivienda ****************************

// ************************** ServicioPublicoVivienda ****************************

  Future<void> syncServiciosPublicosVivienda(SyncStarted event) async {
    final result = await servicioPublicoViviendaUsecase
        .getServiciosPublicosViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      serviciosPublicosViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando servicios públicos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (serviciosPublicosViviendaTemp.isNotEmpty) {
        countRecordsServiciosPublicosViviendaTemp = 0;
        await saveServicioPublicoVivienda(
          event,
          serviciosPublicosViviendaTemp[
              countRecordsServiciosPublicosViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveServicioPublicoVivienda(
    SyncStarted event,
    ServicioPublicoViviendaEntity servicioPublicoVivienda,
  ) async {
    final result = await servicioPublicoViviendaUsecaseDB
        .saveServicioPublicoViviendaUsecaseDB(servicioPublicoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsServiciosPublicosViviendaTemp++;
      if (countRecordsServiciosPublicosViviendaTemp >=
          serviciosPublicosViviendaTemp.length) {
        return;
      }

      ServicioPublicoViviendaEntity servicioPublicoViviendaTemp =
          serviciosPublicosViviendaTemp[
              countRecordsServiciosPublicosViviendaTemp];

      await saveServicioPublicoVivienda(
        event,
        servicioPublicoViviendaTemp,
      );
    });
  }

// ************************** ServicioPublicoVivienda ****************************

// ************************** TechoVivienda ****************************

  Future<void> syncTechosVivienda(SyncStarted event) async {
    final result = await techoViviendaUsecase
        .getTechosViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      techosViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando techos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (techosViviendaTemp.isNotEmpty) {
        countRecordsTechosViviendaTemp = 0;
        await saveTechoVivienda(
          event,
          techosViviendaTemp[countRecordsTechosViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveTechoVivienda(
    SyncStarted event,
    TechoViviendaEntity techoVivienda,
  ) async {
    final result =
        await techoViviendaUsecaseDB.saveTechoViviendaUsecaseDB(techoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTechosViviendaTemp++;
      if (countRecordsTechosViviendaTemp >= techosViviendaTemp.length) {
        return;
      }

      TechoViviendaEntity techoViviendaTemp =
          techosViviendaTemp[countRecordsTechosViviendaTemp];

      await saveTechoVivienda(
        event,
        techoViviendaTemp,
      );
    });
  }

// ************************** TechoVivienda ****************************

// ************************** TenenciaVivienda ****************************

  Future<void> syncTenenciasVivienda(SyncStarted event) async {
    final result = await tenenciaViviendaUsecase
        .getTenenciasViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tenenciasViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tenencias vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tenenciasViviendaTemp.isNotEmpty) {
        countRecordsTenenciasViviendaTemp = 0;
        await saveTenenciaVivienda(
          event,
          tenenciasViviendaTemp[countRecordsTenenciasViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveTenenciaVivienda(
    SyncStarted event,
    TenenciaViviendaEntity tenenciaVivienda,
  ) async {
    final result = await tenenciaViviendaUsecaseDB
        .saveTenenciaViviendaUsecaseDB(tenenciaVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTenenciasViviendaTemp++;
      if (countRecordsTenenciasViviendaTemp >= tenenciasViviendaTemp.length) {
        return;
      }

      TenenciaViviendaEntity tenenciaViviendaTemp =
          tenenciasViviendaTemp[countRecordsTenenciasViviendaTemp];

      await saveTenenciaVivienda(
        event,
        tenenciaViviendaTemp,
      );
    });
  }

// ************************** TenenciaVivienda ****************************

// ************************** TipoCombustibleVivienda ****************************

  Future<void> syncTiposCombustibleVivienda(SyncStarted event) async {
    final result = await tipoCombustibleViviendaUsecase
        .getTiposCombustibleViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiposCombustibleViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos combustible vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tiposCombustibleViviendaTemp.isNotEmpty) {
        countRecordsTiposCombustibleViviendaTemp = 0;
        await saveTipoCombustibleVivienda(
          event,
          tiposCombustibleViviendaTemp[
              countRecordsTiposCombustibleViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveTipoCombustibleVivienda(
    SyncStarted event,
    TipoCombustibleViviendaEntity tipoCombustibleVivienda,
  ) async {
    final result = await tipoCombustibleViviendaUsecaseDB
        .saveTipoCombustibleViviendaUsecaseDB(tipoCombustibleVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTiposCombustibleViviendaTemp++;
      if (countRecordsTiposCombustibleViviendaTemp >=
          tiposCombustibleViviendaTemp.length) {
        return;
      }

      TipoCombustibleViviendaEntity tipoCombustibleViviendaTemp =
          tiposCombustibleViviendaTemp[
              countRecordsTiposCombustibleViviendaTemp];

      await saveTipoCombustibleVivienda(
        event,
        tipoCombustibleViviendaTemp,
      );
    });
  }

// ************************** TipoCombustibleVivienda ****************************

// ************************** TipoSanitarioVivienda ****************************

  Future<void> syncTiposSanitarioVivienda(SyncStarted event) async {
    final result = await tipoSanitarioViviendaUsecase
        .getTiposSanitarioViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiposSanitarioViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos sanitario vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tiposSanitarioViviendaTemp.isNotEmpty) {
        countRecordsTiposSanitarioViviendaTemp = 0;
        await saveTipoSanitarioVivienda(
          event,
          tiposSanitarioViviendaTemp[countRecordsTiposSanitarioViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveTipoSanitarioVivienda(
    SyncStarted event,
    TipoSanitarioViviendaEntity tipoSanitarioVivienda,
  ) async {
    final result = await tipoSanitarioViviendaUsecaseDB
        .saveTipoSanitarioViviendaUsecaseDB(tipoSanitarioVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTiposSanitarioViviendaTemp++;
      if (countRecordsTiposSanitarioViviendaTemp >=
          tiposSanitarioViviendaTemp.length) {
        return;
      }

      TipoSanitarioViviendaEntity tipoSanitarioViviendaTemp =
          tiposSanitarioViviendaTemp[countRecordsTiposSanitarioViviendaTemp];

      await saveTipoSanitarioVivienda(
        event,
        tipoSanitarioViviendaTemp,
      );
    });
  }

// ************************** TipoSanitarioVivienda ****************************

// ************************** TratamientoAguaVivienda ****************************

  Future<void> syncTratamientosAguaVivienda(SyncStarted event) async {
    final result = await tratamientoAguaViviendaUsecase
        .getTratamientosAguaViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tratamientosAguaViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tratamientos agua vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tratamientosAguaViviendaTemp.isNotEmpty) {
        countRecordsTratamientosAguaViviendaTemp = 0;
        await saveTratamientoAguaVivienda(
          event,
          tratamientosAguaViviendaTemp[
              countRecordsTratamientosAguaViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveTratamientoAguaVivienda(
    SyncStarted event,
    TratamientoAguaViviendaEntity tratamientoAguaVivienda,
  ) async {
    final result = await tratamientoAguaViviendaUsecaseDB
        .saveTratamientoAguaViviendaUsecaseDB(tratamientoAguaVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTratamientosAguaViviendaTemp++;
      if (countRecordsTratamientosAguaViviendaTemp >=
          tratamientosAguaViviendaTemp.length) {
        return;
      }

      TratamientoAguaViviendaEntity tratamientoAguaViviendaTemp =
          tratamientosAguaViviendaTemp[
              countRecordsTratamientosAguaViviendaTemp];

      await saveTratamientoAguaVivienda(
        event,
        tratamientoAguaViviendaTemp,
      );
    });
  }

// ************************** TratamientoAguaVivienda ****************************

// ************************** VentilacionesVivienda ****************************

  Future<void> syncVentilacionesVivienda(SyncStarted event) async {
    final result =
        await ventilacionViviendaUsecase.getVentilacionesViviendaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      ventilacionesViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando ventilaciones vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (ventilacionesViviendaTemp.isNotEmpty) {
        countRecordsVentilacionesViviendaTemp = 0;
        await saveVentilacionVivienda(
          event,
          ventilacionesViviendaTemp[countRecordsVentilacionesViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveVentilacionVivienda(
    SyncStarted event,
    VentilacionViviendaEntity ventilacionVivienda,
  ) async {
    final result = await ventilacionViviendaUsecaseDB
        .saveVentilacionViviendaUsecaseDB(ventilacionVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsVentilacionesViviendaTemp++;
      if (countRecordsVentilacionesViviendaTemp >=
          ventilacionesViviendaTemp.length) {
        return;
      }

      VentilacionViviendaEntity ventilacionViviendaTemp =
          ventilacionesViviendaTemp[countRecordsVentilacionesViviendaTemp];

      await saveVentilacionVivienda(
        event,
        ventilacionViviendaTemp,
      );
    });
  }

// ************************** VentilacionesVivienda ****************************

// ************************** TiposVivienda ****************************

  Future<void> syncTiposVivienda(SyncStarted event) async {
    final result = await tipoViviendaUsecase
        .getTiposViviendaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiposViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tiposViviendaTemp.isNotEmpty) {
        countRecordsTiposViviendaTemp = 0;
        await saveTipoVivienda(
          event,
          tiposViviendaTemp[countRecordsTiposViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveTipoVivienda(
    SyncStarted event,
    TipoViviendaEntity tipoVivienda,
  ) async {
    final result =
        await tipoViviendaUsecaseDB.saveTipoViviendaUsecaseDB(tipoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTiposViviendaTemp++;
      if (countRecordsTiposViviendaTemp >= tiposViviendaTemp.length) {
        return;
      }

      TipoViviendaEntity tipoViviendaTemp =
          tiposViviendaTemp[countRecordsTiposViviendaTemp];

      await saveTipoVivienda(
        event,
        tipoViviendaTemp,
      );
    });
  }

// ************************** TiposVivienda ****************************

// ************************** TiposCalendario ****************************

  Future<void> syncTiposCalendario(SyncStarted event) async {
    final result = await tipoCalendarioUsecase.getTiposCalendarioUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiposCalendarioTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos calendario',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tiposCalendarioTemp.isNotEmpty) {
        countRecordsTiposCalendarioTemp = 0;
        await saveTipoCalendario(
          event,
          tiposCalendarioTemp[countRecordsTiposCalendarioTemp],
        );
      } else {}
    });
  }

  Future<void> saveTipoCalendario(
    SyncStarted event,
    TipoCalendarioEntity tipoCalendario,
  ) async {
    final result = await tipoCalendarioUsecaseDB
        .saveTipoCalendarioUsecaseDB(tipoCalendario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTiposCalendarioTemp++;
      if (countRecordsTiposCalendarioTemp >= tiposCalendarioTemp.length) {
        return;
      }

      TipoCalendarioEntity tipoCalendarioTemp =
          tiposCalendarioTemp[countRecordsTiposCalendarioTemp];

      await saveTipoCalendario(
        event,
        tipoCalendarioTemp,
      );
    });
  }

// ************************** TiposCalendario ****************************

// ************************** CursosVida ****************************

  Future<void> syncCursosVida(SyncStarted event) async {
    final result = await cursoVidaUsecase.getCursosVidaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      cursosVidaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando cursos vida',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (cursosVidaTemp.isNotEmpty) {
        countRecordsCursosVidaTemp = 0;
        await saveCursoVida(
          event,
          cursosVidaTemp[countRecordsCursosVidaTemp],
        );
      } else {}
    });
  }

  Future<void> saveCursoVida(
    SyncStarted event,
    CursoVidaEntity cursoVida,
  ) async {
    final result = await cursoVidaUsecaseDB.saveCursoVidaUsecaseDB(cursoVida);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsCursosVidaTemp++;
      if (countRecordsCursosVidaTemp >= cursosVidaTemp.length) {
        return;
      }

      CursoVidaEntity cursoVidaTemp =
          cursosVidaTemp[countRecordsCursosVidaTemp];

      await saveCursoVida(
        event,
        cursoVidaTemp,
      );
    });
  }

// ************************** CursosVida ****************************

// ************************** Etnias ****************************

  Future<void> syncEtnias(SyncStarted event) async {
    final result = await etniaUsecase.getEtniasUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      etniasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando etnias',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (etniasTemp.isNotEmpty) {
        countRecordsEtniasTemp = 0;
        await saveEtnia(
          event,
          etniasTemp[countRecordsEtniasTemp],
        );
      } else {}
    });
  }

  Future<void> saveEtnia(
    SyncStarted event,
    EtniaEntity etnia,
  ) async {
    final result = await etniaUsecaseDB.saveEtniaUsecaseDB(etnia);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEtniasTemp++;
      if (countRecordsEtniasTemp >= etniasTemp.length) {
        return;
      }

      EtniaEntity etniaTemp = etniasTemp[countRecordsEtniasTemp];

      await saveEtnia(
        event,
        etniaTemp,
      );
    });
  }

// ************************** Etnias ****************************

// ************************** Generos ****************************

  Future<void> syncGeneros(SyncStarted event) async {
    final result = await generoUsecase.getGenerosUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      generosTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando generos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (generosTemp.isNotEmpty) {
        countRecordsGenerosTemp = 0;
        await saveGenero(
          event,
          generosTemp[countRecordsGenerosTemp],
        );
      } else {}
    });
  }

  Future<void> saveGenero(
    SyncStarted event,
    GeneroEntity genero,
  ) async {
    final result = await generoUsecaseDB.saveGeneroUsecaseDB(genero);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsGenerosTemp++;
      if (countRecordsGenerosTemp >= generosTemp.length) {
        return;
      }

      GeneroEntity generoTemp = generosTemp[countRecordsGenerosTemp];

      await saveGenero(
        event,
        generoTemp,
      );
    });
  }

// ************************** Generos ****************************

// ************************** GruposRiesgo ****************************

  Future<void> syncGruposRiesgo(SyncStarted event) async {
    final result = await grupoRiesgoUsecase.getGruposRiesgoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      gruposRiesgoTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando grupos riesgo',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (gruposRiesgoTemp.isNotEmpty) {
        countRecordsGruposRiesgoTemp = 0;
        await saveGrupoRiesgo(
          event,
          gruposRiesgoTemp[countRecordsGruposRiesgoTemp],
        );
      } else {}
    });
  }

  Future<void> saveGrupoRiesgo(
    SyncStarted event,
    GrupoRiesgoEntity grupoRiesgo,
  ) async {
    final result =
        await grupoRiesgoUsecaseDB.saveGrupoRiesgoUsecaseDB(grupoRiesgo);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsGruposRiesgoTemp++;
      if (countRecordsGruposRiesgoTemp >= gruposRiesgoTemp.length) {
        return;
      }

      GrupoRiesgoEntity grupoRiesgoTemp =
          gruposRiesgoTemp[countRecordsGruposRiesgoTemp];

      await saveGrupoRiesgo(
        event,
        grupoRiesgoTemp,
      );
    });
  }

// ************************** GruposRiesgo ****************************

// ************************** LenguasManeja ****************************

  Future<void> syncLenguasManeja(SyncStarted event) async {
    final result = await lenguaManejaUsecase.getLenguasManejaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      lenguasManejaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lenguas maneja',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (lenguasManejaTemp.isNotEmpty) {
        countRecordsLenguasManejaTemp = 0;
        await saveLenguaManeja(
          event,
          lenguasManejaTemp[countRecordsLenguasManejaTemp],
        );
      } else {}
    });
  }

  Future<void> saveLenguaManeja(
    SyncStarted event,
    LenguaManejaEntity lenguaManeja,
  ) async {
    final result =
        await lenguaManejaUsecaseDB.saveLenguaManejaUsecaseDB(lenguaManeja);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsLenguasManejaTemp++;
      if (countRecordsLenguasManejaTemp >= lenguasManejaTemp.length) {
        return;
      }

      LenguaManejaEntity lenguaManejaTemp =
          lenguasManejaTemp[countRecordsLenguasManejaTemp];

      await saveLenguaManeja(
        event,
        lenguaManejaTemp,
      );
    });
  }

// ************************** LenguasManeja ****************************

// ************************** NivelesEducativos ****************************

  Future<void> syncNivelesEducativos(SyncStarted event) async {
    final result = await nivelEducativoUsecase.getNivelesEducativosUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      nivelesEducativosTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando niveles educativos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (nivelesEducativosTemp.isNotEmpty) {
        countRecordsNivelesEducativosTemp = 0;
        await saveNivelEducativo(
          event,
          nivelesEducativosTemp[countRecordsNivelesEducativosTemp],
        );
      } else {}
    });
  }

  Future<void> saveNivelEducativo(
    SyncStarted event,
    NivelEducativoEntity nivelEducativo,
  ) async {
    final result = await nivelEducativoUsecaseDB
        .saveNivelEducativoUsecaseDB(nivelEducativo);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsNivelesEducativosTemp++;
      if (countRecordsNivelesEducativosTemp >= nivelesEducativosTemp.length) {
        return;
      }

      NivelEducativoEntity nivelEducativoTemp =
          nivelesEducativosTemp[countRecordsNivelesEducativosTemp];

      await saveNivelEducativo(
        event,
        nivelEducativoTemp,
      );
    });
  }

// ************************** NivelesEducativos ****************************

// ************************** NombresLenguasMaterna ****************************

  Future<void> syncNombresLenguasMaterna(SyncStarted event) async {
    final result = await nombreLenguaMaternaUsecase
        .getNombresLenguasMaternaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      nombresLenguasMaternaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando nombres lenguas maternas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (nombresLenguasMaternaTemp.isNotEmpty) {
        countRecordsNombresLenguasMaternaTemp = 0;
        await saveNombreLenguaMaterna(
          event,
          nombresLenguasMaternaTemp[countRecordsNombresLenguasMaternaTemp],
        );
      } else {}
    });
  }

  Future<void> saveNombreLenguaMaterna(
    SyncStarted event,
    NombreLenguaMaternaEntity nombreLenguaMaterna,
  ) async {
    final result = await nombreLenguaMaternaUsecaseDB
        .saveNombreLenguaMaternaUsecaseDB(nombreLenguaMaterna);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsNombresLenguasMaternaTemp++;
      if (countRecordsNombresLenguasMaternaTemp >=
          nombresLenguasMaternaTemp.length) {
        return;
      }

      NombreLenguaMaternaEntity nombreLenguaMaternaTemp =
          nombresLenguasMaternaTemp[countRecordsNombresLenguasMaternaTemp];

      await saveNombreLenguaMaterna(
        event,
        nombreLenguaMaternaTemp,
      );
    });
  }

// ************************** NombresLenguasMaterna ****************************

// ************************** Ocupaciones ****************************

  Future<void> syncOcupaciones(SyncStarted event) async {
    final result = await ocupacionUsecase.getOcupacionesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      ocupacionesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando ocupaciones',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (ocupacionesTemp.isNotEmpty) {
        countRecordsOcupacionesTemp = 0;
        await saveOcupacion(
          event,
          ocupacionesTemp[countRecordsOcupacionesTemp],
        );
      } else {}
    });
  }

  Future<void> saveOcupacion(
    SyncStarted event,
    OcupacionEntity ocupacion,
  ) async {
    final result = await ocupacionUsecaseDB.saveOcupacionUsecaseDB(ocupacion);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsOcupacionesTemp++;

      if (countRecordsOcupacionesTemp >= ocupacionesTemp.length) {
        return;
      }

      OcupacionEntity ocupacionTemp =
          ocupacionesTemp[countRecordsOcupacionesTemp];

      await saveOcupacion(
        event,
        ocupacionTemp,
      );
    });
  }

// ************************** Ocupaciones ****************************

// ************************** Parentescos ****************************

  Future<void> syncParentescos(SyncStarted event) async {
    final result = await parentescoUsecase.getParentescosUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      parentescosTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando parentescos',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (parentescosTemp.isNotEmpty) {
        countRecordsParentescosTemp = 0;
        await saveParentesco(
          event,
          parentescosTemp[countRecordsParentescosTemp],
        );
      } else {}
    });
  }

  Future<void> saveParentesco(
    SyncStarted event,
    ParentescoEntity parentesco,
  ) async {
    final result =
        await parentescoUsecaseDB.saveParentescoUsecaseDB(parentesco);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsParentescosTemp++;
      if (countRecordsParentescosTemp >= parentescosTemp.length) {
        return;
      }

      ParentescoEntity parentescoTemp =
          parentescosTemp[countRecordsParentescosTemp];

      await saveParentesco(
        event,
        parentescoTemp,
      );
    });
  }

// ************************** Parentescos ****************************

// ************************** PueblosIndigenas ****************************

  Future<void> syncPueblosIndigenas(SyncStarted event) async {
    final result = await puebloIndigenaUsecase
        .getPueblosIndigenasUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      pueblosIndigenasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando pueblos indigenas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (pueblosIndigenasTemp.isNotEmpty) {
        countRecordsPueblosIndigenasTemp = 0;
        await savePuebloIndigena(
          event,
          pueblosIndigenasTemp[countRecordsPueblosIndigenasTemp],
        );
      } else {}
    });
  }

  Future<void> savePuebloIndigena(
    SyncStarted event,
    PuebloIndigenaEntity puebloIndigena,
  ) async {
    final result = await puebloIndigenaUsecaseDB
        .savePuebloIndigenaUsecaseDB(puebloIndigena);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsPueblosIndigenasTemp++;
      if (countRecordsPueblosIndigenasTemp >= pueblosIndigenasTemp.length) {
        return;
      }

      PuebloIndigenaEntity puebloIndigenaTemp =
          pueblosIndigenasTemp[countRecordsPueblosIndigenasTemp];

      await savePuebloIndigena(
        event,
        puebloIndigenaTemp,
      );
    });
  }

// ************************** PueblosIndigenas ****************************

// ************************** Regimenes ****************************

  Future<void> syncRegimenes(SyncStarted event) async {
    final result = await regimenUsecase.getRegimenesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      regimenesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando regimenes',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (regimenesTemp.isNotEmpty) {
        countRecordsRegimenesTemp = 0;
        await saveRegimen(
          event,
          regimenesTemp[countRecordsRegimenesTemp],
        );
      } else {}
    });
  }

  Future<void> saveRegimen(
    SyncStarted event,
    RegimenEntity regimen,
  ) async {
    final result = await regimenUsecaseDB.saveRegimenUsecaseDB(regimen);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsRegimenesTemp++;
      if (countRecordsRegimenesTemp >= regimenesTemp.length) {
        return;
      }

      RegimenEntity regimenTemp = regimenesTemp[countRecordsRegimenesTemp];

      await saveRegimen(
        event,
        regimenTemp,
      );
    });
  }

// ************************** Regimenes ****************************

// ************************** TiposDocumento ****************************

  Future<void> syncTiposDocumento(SyncStarted event) async {
    final result = await tipoDocumentoUsecase.getTiposDocumentoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      tiposDocumentoTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando tipos documento',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (tiposDocumentoTemp.isNotEmpty) {
        countRecordsTiposDocumentoTemp = 0;
        await saveTipoDocumento(
          event,
          tiposDocumentoTemp[countRecordsTiposDocumentoTemp],
        );
      } else {}
    });
  }

  Future<void> saveTipoDocumento(
    SyncStarted event,
    TipoDocumentoEntity tipoDocumento,
  ) async {
    final result =
        await tipoDocumentoUsecaseDB.saveTipoDocumentoUsecaseDB(tipoDocumento);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsTiposDocumentoTemp++;
      if (countRecordsTiposDocumentoTemp >= tiposDocumentoTemp.length) {
        return;
      }

      TipoDocumentoEntity tipoDocumentoTemp =
          tiposDocumentoTemp[countRecordsTiposDocumentoTemp];

      await saveTipoDocumento(
        event,
        tipoDocumentoTemp,
      );
    });
  }

// ************************** TiposDocumento ****************************

// ************************** ActividadesFisicas ****************************

  Future<void> syncActividadesFisicas(SyncStarted event) async {
    final result = await actividadFisicaUsecase.getActividadesFisicasUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      actividadesFisicasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando actividades físicas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (actividadesFisicasTemp.isNotEmpty) {
        countRecordsActividadesFisicasTemp = 0;
        await saveActividadFisica(
          event,
          actividadesFisicasTemp[countRecordsActividadesFisicasTemp],
        );
      } else {}
    });
  }

  Future<void> saveActividadFisica(
    SyncStarted event,
    ActividadFisicaEntity actividadFisica,
  ) async {
    final result = await actividadFisicaUsecaseDB
        .saveActividadFisicaUsecaseDB(actividadFisica);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsActividadesFisicasTemp++;
      if (countRecordsActividadesFisicasTemp >= actividadesFisicasTemp.length) {
        return;
      }

      ActividadFisicaEntity actividadFisicaTemp =
          actividadesFisicasTemp[countRecordsActividadesFisicasTemp];

      await saveActividadFisica(
        event,
        actividadFisicaTemp,
      );
    });
  }

// ************************** ActividadesFisicas ****************************

// ************************** Alimentaciones ****************************

  Future<void> syncAlimentaciones(SyncStarted event) async {
    final result = await alimentacionUsecase.getAlimentacionesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      alimentacionesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando alimentación',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (alimentacionesTemp.isNotEmpty) {
        countRecordsAlimentacionesTemp = 0;
        await saveAlimentacion(
          event,
          alimentacionesTemp[countRecordsAlimentacionesTemp],
        );
      } else {}
    });
  }

  Future<void> saveAlimentacion(
    SyncStarted event,
    AlimentacionEntity alimentacion,
  ) async {
    final alimentacionModel = AlimentacionModel.fromEntity(alimentacion);
    final result = await alimentacionUsecaseDB
        .saveAlimentacionUsecaseDB(alimentacionModel);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsAlimentacionesTemp++;
      if (countRecordsAlimentacionesTemp >= alimentacionesTemp.length) {
        return;
      }

      AlimentacionEntity alimentacionTemp =
          alimentacionesTemp[countRecordsAlimentacionesTemp];

      await saveAlimentacion(
        event,
        alimentacionTemp,
      );
    });
  }

// ************************** Alimentaciones ****************************

// ************************** CigarrillosDia ****************************

  Future<void> syncCigarrillosDia(SyncStarted event) async {
    final result = await cigarrilloDiaUsecase.getCigarrillosDiaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      cigarrillosDiaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando cigarrillos día',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (cigarrillosDiaTemp.isNotEmpty) {
        countRecordsCigarrillosDiaTemp = 0;
        await saveCigarrilloDia(
          event,
          cigarrillosDiaTemp[countRecordsCigarrillosDiaTemp],
        );
      } else {}
    });
  }

  Future<void> saveCigarrilloDia(
    SyncStarted event,
    CigarrilloDiaEntity cigarrilloDia,
  ) async {
    final result =
        await cigarrilloDiaUsecaseDB.saveCigarrilloDiaUsecaseDB(cigarrilloDia);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsCigarrillosDiaTemp++;
      if (countRecordsCigarrillosDiaTemp >= cigarrillosDiaTemp.length) {
        return;
      }

      CigarrilloDiaEntity cigarrilloDiaTemp =
          cigarrillosDiaTemp[countRecordsCigarrillosDiaTemp];

      await saveCigarrilloDia(
        event,
        cigarrilloDiaTemp,
      );
    });
  }

// ************************** CigarrillosDia ****************************

// ************************** ConsumosAlcohol ****************************

  Future<void> syncConsumosAlcohol(SyncStarted event) async {
    final result = await consumoAlcoholUsecase.getConsumosAlcoholUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      consumosAlcoholTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando consumo alcohol',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (consumosAlcoholTemp.isNotEmpty) {
        countRecordsConsumosAlcoholTemp = 0;
        await saveConsumoAlcohol(
          event,
          consumosAlcoholTemp[countRecordsConsumosAlcoholTemp],
        );
      } else {}
    });
  }

  Future<void> saveConsumoAlcohol(
    SyncStarted event,
    ConsumoAlcoholEntity consumoAlcohol,
  ) async {
    final result = await consumoAlcoholUsecaseDB
        .saveConsumoAlcoholUsecaseDB(consumoAlcohol);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsConsumosAlcoholTemp++;
      if (countRecordsConsumosAlcoholTemp >= consumosAlcoholTemp.length) {
        return;
      }

      ConsumoAlcoholEntity consumoAlcoholTemp =
          consumosAlcoholTemp[countRecordsConsumosAlcoholTemp];

      await saveConsumoAlcohol(
        event,
        consumoAlcoholTemp,
      );
    });
  }

// ************************** ConsumosAlcohol ****************************

// ************************** CondicionesNutricionales ****************************

  Future<void> syncCondicionesNutricionales(SyncStarted event) async {
    final result =
        await condicionNutricionalUsecase.getCondicionesNutricionalesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      condicionesNutricionalesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando condiciones nutricionales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (condicionesNutricionalesTemp.isNotEmpty) {
        countRecordsCondicionesNutricionalesTemp = 0;
        await saveCondicionNutricional(
          event,
          condicionesNutricionalesTemp[
              countRecordsCondicionesNutricionalesTemp],
        );
      } else {}
    });
  }

  Future<void> saveCondicionNutricional(
    SyncStarted event,
    CondicionNutricionalEntity condicionNutricional,
  ) async {
    final result = await condicionNutricionalUsecaseDB
        .saveCondicionNutricionalUsecaseDB(condicionNutricional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsCondicionesNutricionalesTemp++;
      if (countRecordsCondicionesNutricionalesTemp >=
          condicionesNutricionalesTemp.length) {
        return;
      }

      CondicionNutricionalEntity condicionNutricionalTemp =
          condicionesNutricionalesTemp[
              countRecordsCondicionesNutricionalesTemp];

      await saveCondicionNutricional(
        event,
        condicionNutricionalTemp,
      );
    });
  }

// ************************** CondicionesNutricionales ****************************

// ************************** ConductasSeguir ****************************

  Future<void> syncConductasSeguir(SyncStarted event) async {
    final result = await conductaSeguirUsecase.getConductasSeguirUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      conductasSeguirTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando conductas seguir',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (conductasSeguirTemp.isNotEmpty) {
        countRecordsConductasSeguirTemp = 0;
        await saveConductaSeguir(
          event,
          conductasSeguirTemp[countRecordsConductasSeguirTemp],
        );
      } else {}
    });
  }

  Future<void> saveConductaSeguir(
    SyncStarted event,
    ConductaSeguirEntity conductaSeguir,
  ) async {
    final result = await conductaSeguirUsecaseDB
        .saveConductaSeguirUsecaseDB(conductaSeguir);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsConductasSeguirTemp++;
      if (countRecordsConductasSeguirTemp >= conductasSeguirTemp.length) {
        return;
      }

      ConductaSeguirEntity conductaSeguirTemp =
          conductasSeguirTemp[countRecordsConductasSeguirTemp];

      await saveConductaSeguir(
        event,
        conductaSeguirTemp,
      );
    });
  }

// ************************** ConductasSeguir ****************************

// ************************** EsquemasVacunacion ****************************

  Future<void> syncEsquemasVacunacion(SyncStarted event) async {
    final result =
        await esquemaVacunacionUsecase.getEsquemasVacunacionUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      esquemasVacunacionTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando esquemas vacunacion',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (esquemasVacunacionTemp.isNotEmpty) {
        countRecordsEsquemasVacunacionTemp = 0;
        await saveEsquemaVacunacion(
          event,
          esquemasVacunacionTemp[countRecordsEsquemasVacunacionTemp],
        );
      } else {}
    });
  }

  Future<void> saveEsquemaVacunacion(
    SyncStarted event,
    EsquemaVacunacionEntity esquemaVacunacion,
  ) async {
    final result = await esquemaVacunacionUsecaseDB
        .saveEsquemaVacunacionUsecaseDB(esquemaVacunacion);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEsquemasVacunacionTemp++;
      if (countRecordsEsquemasVacunacionTemp >= esquemasVacunacionTemp.length) {
        return;
      }

      EsquemaVacunacionEntity esquemaVacunacionTemp =
          esquemasVacunacionTemp[countRecordsEsquemasVacunacionTemp];

      await saveEsquemaVacunacion(
        event,
        esquemaVacunacionTemp,
      );
    });
  }

// ************************** EsquemasVacunacion ****************************

// ************************** LugaresVacunacion ****************************

  Future<void> syncLugaresVacunacion(SyncStarted event) async {
    final result = await lugarVacunacionUsecase.getLugaresVacunacionUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      lugaresVacunacionTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lugares vacunacion',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (lugaresVacunacionTemp.isNotEmpty) {
        countRecordsLugaresVacunacionTemp = 0;
        await saveLugarVacunacion(
          event,
          lugaresVacunacionTemp[countRecordsLugaresVacunacionTemp],
        );
      } else {}
    });
  }

  Future<void> saveLugarVacunacion(
    SyncStarted event,
    LugarVacunacionEntity lugarVacunacion,
  ) async {
    final result = await lugarVacunacionUsecaseDB
        .saveLugarVacunacionUsecaseDB(lugarVacunacion);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsLugaresVacunacionTemp++;
      if (countRecordsLugaresVacunacionTemp >= lugaresVacunacionTemp.length) {
        return;
      }

      LugarVacunacionEntity lugarVacunacionTemp =
          lugaresVacunacionTemp[countRecordsLugaresVacunacionTemp];

      await saveLugarVacunacion(
        event,
        lugarVacunacionTemp,
      );
    });
  }

// ************************** LugaresVacunacion ****************************

// ************************** MetodosPlanificacion ****************************

  Future<void> syncMetodosPlanificacion(SyncStarted event) async {
    final result =
        await metodoPlanificacionUsecase.getMetodosPlanificacionUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      metodosPlanificacionTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando metodos planificacion',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (metodosPlanificacionTemp.isNotEmpty) {
        countRecordsMetodosPlanificacionTemp = 0;
        await saveMetodoPlanificacion(
          event,
          metodosPlanificacionTemp[countRecordsMetodosPlanificacionTemp],
        );
      } else {}
    });
  }

  Future<void> saveMetodoPlanificacion(
    SyncStarted event,
    MetodoPlanificacionEntity metodoPlanificacion,
  ) async {
    final result = await metodoPlanificacionUsecaseDB
        .saveMetodoPlanificacionUsecaseDB(metodoPlanificacion);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsMetodosPlanificacionTemp++;
      if (countRecordsMetodosPlanificacionTemp >=
          metodosPlanificacionTemp.length) {
        return;
      }

      MetodoPlanificacionEntity metodoPlanificacionTemp =
          metodosPlanificacionTemp[countRecordsMetodosPlanificacionTemp];

      await saveMetodoPlanificacion(
        event,
        metodoPlanificacionTemp,
      );
    });
  }

// ************************** MetodosPlanificacion ****************************

// ************************** NombresEnfermedades ****************************

  Future<void> syncNombresEnfermedades(SyncStarted event) async {
    final result =
        await nombreEnfermedadUsecase.getNombresEnfermedadesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      nombresEnfermedadesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando nombres enfermedades',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (nombresEnfermedadesTemp.isNotEmpty) {
        countRecordsNombresEnfermedadesTemp = 0;
        await saveNombreEnfermedad(
          event,
          nombresEnfermedadesTemp[countRecordsNombresEnfermedadesTemp],
        );
      } else {}
    });
  }

  Future<void> saveNombreEnfermedad(
    SyncStarted event,
    NombreEnfermedadEntity nombreEnfermedad,
  ) async {
    final result = await nombreEnfermedadUsecaseDB
        .saveNombreEnfermedadUsecaseDB(nombreEnfermedad);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsNombresEnfermedadesTemp++;
      if (countRecordsNombresEnfermedadesTemp >=
          nombresEnfermedadesTemp.length) {
        return;
      }

      NombreEnfermedadEntity nombreEnfermedadTemp =
          nombresEnfermedadesTemp[countRecordsNombresEnfermedadesTemp];

      await saveNombreEnfermedad(
        event,
        nombreEnfermedadTemp,
      );
    });
  }

// ************************** NombresEnfermedades ****************************

// ************************** SeguimientoEnfermedades ****************************

  Future<void> syncSeguimientoEnfermedades(SyncStarted event) async {
    final result =
        await seguimientoEnfermedadUsecase.getSeguimientoEnfermedadesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      seguimientoEnfermedadesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando seguimiento enfermedades',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (seguimientoEnfermedadesTemp.isNotEmpty) {
        countRecordsSeguimientoEnfermedadesTemp = 0;
        await saveSeguimientoEnfermedad(
          event,
          seguimientoEnfermedadesTemp[countRecordsSeguimientoEnfermedadesTemp],
        );
      } else {}
    });
  }

  Future<void> saveSeguimientoEnfermedad(
    SyncStarted event,
    SeguimientoEnfermedadEntity seguimientoEnfermedad,
  ) async {
    final result = await seguimientoEnfermedadUsecaseDB
        .saveSeguimientoEnfermedadUsecaseDB(seguimientoEnfermedad);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsSeguimientoEnfermedadesTemp++;
      if (countRecordsSeguimientoEnfermedadesTemp >=
          seguimientoEnfermedadesTemp.length) {
        return;
      }

      SeguimientoEnfermedadEntity seguimientoEnfermedadTemp =
          seguimientoEnfermedadesTemp[countRecordsSeguimientoEnfermedadesTemp];

      await saveSeguimientoEnfermedad(
        event,
        seguimientoEnfermedadTemp,
      );
    });
  }

// ************************** SeguimientoEnfermedades ****************************

// ************************** ServiciosSolicitados ****************************

  Future<void> syncServiciosSolicitados(SyncStarted event) async {
    final result =
        await servicioSolicitadoUsecase.getServiciosSolicitadosUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      serviciosSolicitadosTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando servicios solicitados',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (serviciosSolicitadosTemp.isNotEmpty) {
        countRecordsServiciosSolicitadosTemp = 0;
        await saveServicioSolicitado(
          event,
          serviciosSolicitadosTemp[countRecordsServiciosSolicitadosTemp],
        );
      } else {}
    });
  }

  Future<void> saveServicioSolicitado(
    SyncStarted event,
    ServicioSolicitadoEntity servicioSolicitado,
  ) async {
    final result = await servicioSolicitadoUsecaseDB
        .saveServicioSolicitadoUsecaseDB(servicioSolicitado);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsServiciosSolicitadosTemp++;
      if (countRecordsServiciosSolicitadosTemp >=
          serviciosSolicitadosTemp.length) {
        return;
      }

      ServicioSolicitadoEntity servicioSolicitadoTemp =
          serviciosSolicitadosTemp[countRecordsServiciosSolicitadosTemp];

      await saveServicioSolicitado(
        event,
        servicioSolicitadoTemp,
      );
    });
  }

// ************************** ServiciosSolicitados ****************************

// ************************** UltimasVecesInstSalud ****************************

  Future<void> syncUltimasVecesInstSalud(SyncStarted event) async {
    final result =
        await ultimaVezInstSaludUsecase.getUltimasVecesInstSaludUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      ultimasVecesInstSaludTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando ultima vez inst salud',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (ultimasVecesInstSaludTemp.isNotEmpty) {
        countRecordsUltimasVecesInstSaludTemp = 0;
        await saveUltimaVezInstSalud(
          event,
          ultimasVecesInstSaludTemp[countRecordsUltimasVecesInstSaludTemp],
        );
      } else {}
    });
  }

  Future<void> saveUltimaVezInstSalud(
    SyncStarted event,
    UltimaVezInstSaludEntity ultimaVezInstSalud,
  ) async {
    final result = await ultimaVezInstSaludUsecaseDB
        .saveUltimaVezInstSaludUsecaseDB(ultimaVezInstSalud);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsUltimasVecesInstSaludTemp++;
      if (countRecordsUltimasVecesInstSaludTemp >=
          ultimasVecesInstSaludTemp.length) {
        return;
      }

      UltimaVezInstSaludEntity ultimaVezInstSaludTemp =
          ultimasVecesInstSaludTemp[countRecordsUltimasVecesInstSaludTemp];

      await saveUltimaVezInstSalud(
        event,
        ultimaVezInstSaludTemp,
      );
    });
  }

// ************************** UltimasVecesInstSalud ****************************

// ************************** EnfermedadesAcude ****************************

  Future<void> syncEnfermedadesAcude(SyncStarted event) async {
    final result = await enfermedadAcudeUsecase.getEnfermedadesAcudeUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      enfermedadesAcudeTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando enfermedades acude',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (enfermedadesAcudeTemp.isNotEmpty) {
        countRecordsEnfermedadesAcudeTemp = 0;
        await saveEnfermedadAcude(
          event,
          enfermedadesAcudeTemp[countRecordsEnfermedadesAcudeTemp],
        );
      } else {}
    });
  }

  Future<void> saveEnfermedadAcude(
    SyncStarted event,
    EnfermedadAcudeEntity enfermedadAcude,
  ) async {
    final result = await enfermedadAcudeUsecaseDB
        .saveEnfermedadAcudeUsecaseDB(enfermedadAcude);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEnfermedadesAcudeTemp++;
      if (countRecordsEnfermedadesAcudeTemp >= enfermedadesAcudeTemp.length) {
        return;
      }

      EnfermedadAcudeEntity enfermedadAcudeTemp =
          enfermedadesAcudeTemp[countRecordsEnfermedadesAcudeTemp];

      await saveEnfermedadAcude(
        event,
        enfermedadAcudeTemp,
      );
    });
  }

// ************************** EnfermedadesAcude ****************************

// ************************** EnfermedadesTratamiento ****************************

  Future<void> syncEnfermedadesTratamiento(SyncStarted event) async {
    final result =
        await enfermedadTratamientoUsecase.getEnfermedadesTratamientoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      enfermedadesTratamientoTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando enfermedades tratamiento',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (enfermedadesTratamientoTemp.isNotEmpty) {
        countRecordsEnfermedadesTratamientoTemp = 0;
        await saveEnfermedadTratamiento(
          event,
          enfermedadesTratamientoTemp[countRecordsEnfermedadesTratamientoTemp],
        );
      } else {}
    });
  }

  Future<void> saveEnfermedadTratamiento(
    SyncStarted event,
    EnfermedadTratamientoEntity enfermedadTratamiento,
  ) async {
    final result = await enfermedadTratamientoUsecaseDB
        .saveEnfermedadTratamientoUsecaseDB(enfermedadTratamiento);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEnfermedadesTratamientoTemp++;
      if (countRecordsEnfermedadesTratamientoTemp >=
          enfermedadesTratamientoTemp.length) {
        return;
      }

      EnfermedadTratamientoEntity enfermedadTratamientoTemp =
          enfermedadesTratamientoTemp[countRecordsEnfermedadesTratamientoTemp];

      await saveEnfermedadTratamiento(
        event,
        enfermedadTratamientoTemp,
      );
    });
  }

// ************************** EnfermedadesTratamiento ****************************

// ************************** EnfermedadesTradicionales ****************************

  Future<void> syncEnfermedadesTradicionales(SyncStarted event) async {
    final result = await enfermedadTradicionalUsecase
        .getEnfermedadesTradicionalesUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      enfermedadesTradicionalesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando enfermedades tradicionales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (enfermedadesTradicionalesTemp.isNotEmpty) {
        countRecordsEnfermedadesTradicionalesTemp = 0;
        await saveEnfermedadTradicional(
          event,
          enfermedadesTradicionalesTemp[
              countRecordsEnfermedadesTradicionalesTemp],
        );
      } else {}
    });
  }

  Future<void> saveEnfermedadTradicional(
    SyncStarted event,
    EnfermedadTradicionalEntity enfermedadTradicional,
  ) async {
    final result = await enfermedadTradicionalUsecaseDB
        .saveEnfermedadTradicionalUsecaseDB(enfermedadTradicional);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEnfermedadesTradicionalesTemp++;
      if (countRecordsEnfermedadesTradicionalesTemp >=
          enfermedadesTradicionalesTemp.length) {
        return;
      }

      EnfermedadTradicionalEntity enfermedadTradicionalTemp =
          enfermedadesTradicionalesTemp[
              countRecordsEnfermedadesTradicionalesTemp];

      await saveEnfermedadTradicional(
        event,
        enfermedadTradicionalTemp,
      );
    });
  }

// ************************** EnfermedadesTradicionales ****************************

// ************************** LugaresAtencionMedico ****************************

  Future<void> syncLugaresAtencionMedico(SyncStarted event) async {
    final result =
        await lugarAtencionMedicoUsecase.getLugaresAtencionMedicoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      lugaresAtencionMedicoTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lugares atención médico',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (lugaresAtencionMedicoTemp.isNotEmpty) {
        countRecordsLugaresAtencionMedicoTemp = 0;
        await saveLugarAtencionMedico(
          event,
          lugaresAtencionMedicoTemp[countRecordsLugaresAtencionMedicoTemp],
        );
      } else {}
    });
  }

  Future<void> saveLugarAtencionMedico(
    SyncStarted event,
    LugarAtencionMedicoEntity lugarAtencionMedico,
  ) async {
    final result = await lugarAtencionMedicoUsecaseDB
        .saveLugarAtencionMedicoUsecaseDB(lugarAtencionMedico);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsLugaresAtencionMedicoTemp++;
      if (countRecordsLugaresAtencionMedicoTemp >=
          lugaresAtencionMedicoTemp.length) {
        return;
      }

      LugarAtencionMedicoEntity lugarAtencionMedicoTemp =
          lugaresAtencionMedicoTemp[countRecordsLugaresAtencionMedicoTemp];

      await saveLugarAtencionMedico(
        event,
        lugarAtencionMedicoTemp,
      );
    });
  }

// ************************** LugaresAtencionMedico ****************************

// ************************** LugaresPlantasMedicinales ****************************

  Future<void> syncLugaresPlantasMedicinales(SyncStarted event) async {
    final result = await lugarPlantaMedicinalUsecase
        .getLugaresPlantasMedicinalesUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      lugaresPlantasMedicinalesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lugares plantas medicinales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (lugaresPlantasMedicinalesTemp.isNotEmpty) {
        countRecordsLugaresPlantasMedicinalesTemp = 0;
        await saveLugarPlantaMedicinal(
          event,
          lugaresPlantasMedicinalesTemp[
              countRecordsLugaresPlantasMedicinalesTemp],
        );
      } else {}
    });
  }

  Future<void> saveLugarPlantaMedicinal(
    SyncStarted event,
    LugarPlantaMedicinalEntity lugarPlantaMedicinal,
  ) async {
    final result = await lugarPlantaMedicinalUsecaseDB
        .saveLugarPlantaMedicinalUsecaseDB(lugarPlantaMedicinal);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsLugaresPlantasMedicinalesTemp++;
      if (countRecordsLugaresPlantasMedicinalesTemp >=
          lugaresPlantasMedicinalesTemp.length) {
        return;
      }

      LugarPlantaMedicinalEntity lugarPlantaMedicinalTemp =
          lugaresPlantasMedicinalesTemp[
              countRecordsLugaresPlantasMedicinalesTemp];

      await saveLugarPlantaMedicinal(
        event,
        lugarPlantaMedicinalTemp,
      );
    });
  }

// ************************** LugaresPlantasMedicinales ****************************

// ************************** PlantasMedicinales ****************************

  Future<void> syncPlantasMedicinales(SyncStarted event) async {
    final result = await plantaMedicinalUsecase
        .getPlantasMedicinalesUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      plantasMedicinalesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando plantas medicinales',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (plantasMedicinalesTemp.isNotEmpty) {
        countRecordsPlantasMedicinalesTemp = 0;
        await savePlantaMedicinal(
          event,
          plantasMedicinalesTemp[countRecordsPlantasMedicinalesTemp],
        );
      } else {}
    });
  }

  Future<void> savePlantaMedicinal(
    SyncStarted event,
    PlantaMedicinalEntity plantaMedicinal,
  ) async {
    final result = await plantaMedicinalUsecaseDB
        .savePlantaMedicinalUsecaseDB(plantaMedicinal);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsPlantasMedicinalesTemp++;
      if (countRecordsPlantasMedicinalesTemp >= plantasMedicinalesTemp.length) {
        return;
      }

      PlantaMedicinalEntity plantaMedicinalTemp =
          plantasMedicinalesTemp[countRecordsPlantasMedicinalesTemp];

      await savePlantaMedicinal(
        event,
        plantaMedicinalTemp,
      );
    });
  }

// ************************** PlantasMedicinales ****************************

// ************************** ReligionesProfesa ****************************

  Future<void> syncReligionesProfesa(SyncStarted event) async {
    final result = await religionProfesaUsecase.getReligionesProfesaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      religionesProfesaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando religiones profesa',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (religionesProfesaTemp.isNotEmpty) {
        countRecordsReligionesProfesaTemp = 0;
        await saveReligionProfesa(
          event,
          religionesProfesaTemp[countRecordsReligionesProfesaTemp],
        );
      } else {}
    });
  }

  Future<void> saveReligionProfesa(
    SyncStarted event,
    ReligionProfesaEntity religionProfesa,
  ) async {
    final result = await religionProfesaUsecaseDB
        .saveReligionProfesaUsecaseDB(religionProfesa);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsReligionesProfesaTemp++;
      if (countRecordsReligionesProfesaTemp >= religionesProfesaTemp.length) {
        return;
      }

      ReligionProfesaEntity religionProfesaTemp =
          religionesProfesaTemp[countRecordsReligionesProfesaTemp];

      await saveReligionProfesa(
        event,
        religionProfesaTemp,
      );
    });
  }

// ************************** ReligionesProfesa ****************************

// ************************** EventosCostumbresParticipa ****************************

  Future<void> syncEventosCostumbresParticipa(SyncStarted event) async {
    final result = await eventoCostumbreParticipaUsecase
        .getEventosCostumbresParticipaUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      eventosCostumbresParticipaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando eventos costumbres participa',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (eventosCostumbresParticipaTemp.isNotEmpty) {
        countRecordsEventosCostumbresParticipaTemp = 0;
        await saveEventoCostumbreParticipa(
          event,
          eventosCostumbresParticipaTemp[
              countRecordsEventosCostumbresParticipaTemp],
        );
      } else {}
    });
  }

  Future<void> saveEventoCostumbreParticipa(
    SyncStarted event,
    EventoCostumbreParticipaEntity eventoCostumbreParticipa,
  ) async {
    final result = await eventoCostumbreParticipaUsecaseDB
        .saveEventoCostumbreParticipaUsecaseDB(eventoCostumbreParticipa);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsEventosCostumbresParticipaTemp++;
      if (countRecordsEventosCostumbresParticipaTemp >=
          eventosCostumbresParticipaTemp.length) {
        return;
      }

      EventoCostumbreParticipaEntity eventoCostumbreParticipaTemp =
          eventosCostumbresParticipaTemp[
              countRecordsEventosCostumbresParticipaTemp];

      await saveEventoCostumbreParticipa(
        event,
        eventoCostumbreParticipaTemp,
      );
    });
  }

// ************************** EventosCostumbresParticipa ****************************

// ************************** CostumbresPractican ****************************

  Future<void> syncCostumbresPractican(SyncStarted event) async {
    final result = await costumbrePracticaUsecase
        .getCostumbresPracticanUsecase(event.usuario.departamentoId!);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      costumbresPracticanTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando eventos costumbres participa',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (costumbresPracticanTemp.isNotEmpty) {
        countRecordsCostumbresPracticanTemp = 0;
        await saveCostumbrePractica(
          event,
          costumbresPracticanTemp[countRecordsCostumbresPracticanTemp],
        );
      } else {}
    });
  }

  Future<void> saveCostumbrePractica(
    SyncStarted event,
    CostumbrePracticaEntity costumbrePractica,
  ) async {
    final result = await costumbrePracticaUsecaseDB
        .saveCostumbrePracticaUsecaseDB(costumbrePractica);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsCostumbresPracticanTemp++;
      if (countRecordsCostumbresPracticanTemp >=
          costumbresPracticanTemp.length) {
        return;
      }

      CostumbrePracticaEntity costumbrePracticaTemp =
          costumbresPracticanTemp[countRecordsCostumbresPracticanTemp];

      await saveCostumbrePractica(
        event,
        costumbrePracticaTemp,
      );
    });
  }

// ************************** CostumbresPractican ****************************

// ************************** SancionesJusticia ****************************

  Future<void> syncSancionesJusticia(SyncStarted event) async {
    final result = await sancionJusticiaUsecase.getSancionesJusticiaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      sancionesJusticiaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando eventos costumbres participa',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (sancionesJusticiaTemp.isNotEmpty) {
        countRecordsSancionesJusticiaTemp = 0;
        await saveSancionJusticia(
          event,
          sancionesJusticiaTemp[countRecordsSancionesJusticiaTemp],
        );
      } else {}
    });
  }

  Future<void> saveSancionJusticia(
    SyncStarted event,
    SancionJusticiaEntity sancionJusticia,
  ) async {
    final result = await sancionJusticiaUsecaseDB
        .saveSancionJusticiaUsecaseDB(sancionJusticia);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsSancionesJusticiaTemp++;
      if (countRecordsSancionesJusticiaTemp >= sancionesJusticiaTemp.length) {
        return;
      }

      SancionJusticiaEntity sancionJusticiaTemp =
          sancionesJusticiaTemp[countRecordsSancionesJusticiaTemp];

      await saveSancionJusticia(
        event,
        sancionJusticiaTemp,
      );
    });
  }

// ************************** SancionesJusticia ****************************

// ************************** CuartosVivienda ****************************

  Future<void> syncCuartosVivienda(SyncStarted event) async {
    final result = await cuartoViviendaUsecase.getCuartosViviendaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      cuartosViviendaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando cuartos vivienda',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (cuartosViviendaTemp.isNotEmpty) {
        countRecordsCuartosViviendaTemp = 0;
        await saveCuartoVivienda(
          event,
          cuartosViviendaTemp[countRecordsCuartosViviendaTemp],
        );
      } else {}
    });
  }

  Future<void> saveCuartoVivienda(
    SyncStarted event,
    CuartoViviendaEntity cuartoVivienda,
  ) async {
    final result = await cuartoViviendaUsecaseDB
        .saveCuartoViviendaUsecaseDB(cuartoVivienda);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsCuartosViviendaTemp++;
      if (countRecordsCuartosViviendaTemp >= cuartosViviendaTemp.length) {
        return;
      }

      CuartoViviendaEntity cuartoViviendaTemp =
          cuartosViviendaTemp[countRecordsCuartosViviendaTemp];

      await saveCuartoVivienda(
        event,
        cuartoViviendaTemp,
      );
    });
  }

// ************************** CuartosVivienda ****************************

// ************************** Fichas ****************************

  Future<void> syncFichas(SyncStarted event) async {
    String userName = event.usuario.userName!;
    final result = await fichaUsecase.getFichasUsecase(userName);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
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
        add(SyncIncrementChanged(state.syncProgressModel.copyWith(
            title: 'Sincronización completada',
            counter: state.syncProgressModel.counter + 1,
            total: state.syncProgressModel.totalAccesorias)));
      }
    });
  }

  Future<void> saveFichas(
    SyncStarted event,
    FichaEntity ficha,
  ) async {
    final result = await fichaUsecaseDB.createFichaCompletaUsecaseDB(ficha);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      countRecordsFichasTemp++;
      if (countRecordsFichasTemp >= fichasTemp.length) {
        // add(SyncIncrementChanged(state.syncProgressModel.copyWith(
        //     title: 'Sincronización completada',
        //     counter: state.syncProgressModel.counter + 1,
        //     total: state.syncProgressModel.totalAccesorias)));
        return;
      }

      FichaEntity fichaTemp = fichasTemp[countRecordsFichasTemp];
      await saveFichas(
        event,
        fichaTemp,
      );
    });
  }
}
