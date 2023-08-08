import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/usuario_entity.dart';
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
import '../../../domain/usecases/ficha/ficha_usecase.dart';
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
import '../../../domain/usecases/sync_log/sync_log_exports.dart';
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
import '../../../services/connection_sqlite_service.dart';

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

  final FichaUsecase fichaUsecase;
  final SyncLogUsecaseDB syncLogDB;

  int totalAccesories = 69;

  List<AfiliadoEntity> afiliadosTemp = [];
  List<DificultadAccesoCAEntity> dificultadesAccesoCATemp = [];
  List<EstadoViaEntity> estadosViasTemp = [];
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
    required this.fichaUsecase,
    required this.syncLogDB,
  }) : super(SyncInitial()) {
    on<SyncStarted>((event, emit) async {
      if (event.type == 'A') {
        add(Downloading(state.syncProgressModel.copyWith(
          title: 'Descargando afiliados',
        )));

        ConnectionSQLiteService.truncateTable('Afiliado').then((value) async {
          afiliadosTemp = [];
          await syncAfiliados(event, 1, 10000);
        });
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
    on<SyncLog>((event, emit) => emit(IncompleteSync(event.syncLog)));
  }

// ************************** Ficha ****************************
  Future<void> syncFicha(
    SyncStarted event,
  ) async {
    final result = await fichaUsecase.createFichaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) {
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
        title: 'Sincronización ficha completada',
      )));
    });
  }
// ************************** Ficha ****************************

// ************************** Afiliados ****************************
  Future<void> syncAfiliados(
    SyncStarted event,
    int pagina,
    int registrosPorPagina,
  ) async {
    final result = await afiliadoUsecase.getAfiliadosUsecase(
        event.usuario.departamentoId!, pagina, registrosPorPagina);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      afiliadosTemp.addAll(data.resultado);
      add(Downloading(state.syncProgressModel.copyWith(
          title: 'Descargando afiliados',
          counter: afiliadosTemp.length,
          total: data.totalRegistros,
          percent: calculatePercent())));

      if (afiliadosTemp.length < data.totalRegistros &&
          pagina < data.totalPaginas) {
        pagina++;
        await syncAfiliados(event, pagina, registrosPorPagina);
      }

      for (int i = 0; i < afiliadosTemp.length; i++) {
        await saveAfiliado(event, afiliadosTemp[i]);
      }
    });
  }

  Future<void> saveAfiliado(
    SyncStarted event,
    AfiliadoEntity afiliado,
  ) async {
    final result = await afiliadoUsecaseDB.saveAfiliadoUsecaseDB(afiliado);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      add(SyncPercentageChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando afiliados',
          counter: data,
          total: afiliadosTemp.length,
          percent: calculatePercent())));

      if (data >= afiliadosTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'DificultadesAcceso_CentroAtencion')
            .then((value) async {
          dificultadesAccesoCATemp = [];
          await syncDificultadesAccesoCA(event);
        });
        return;
      }

      AfiliadoEntity afiliadoTemp = afiliadosTemp[data];

      await saveAfiliado(
        event,
        afiliadoTemp,
      );
    });
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
          total: totalAccesories)));

      await saveDificultadAccesoCA(
        event,
        dificultadesAccesoCATemp[0],
      );
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
      if (data >= dificultadesAccesoCATemp.length) {
        ConnectionSQLiteService.truncateTable('EstadoVias').then((value) async {
          estadosViasTemp = [];
          await syncEstadosVias(event);
        });
        return;
      }

      DificultadAccesoCAEntity dificultadAccesoCATemp =
          dificultadesAccesoCATemp[data];

      await saveDificultadAccesoCA(
        event,
        dificultadAccesoCATemp,
      );
    });
  }

// ************************** Dificultades acceso CA ****************************

// ************************** Estado Vias ****************************

  Future<void> syncEstadosVias(SyncStarted event) async {
    final result = await estadoViaUsecase.getEstadosViasUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      estadosViasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando estados vías',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveEstadoVia(
        event,
        estadosViasTemp[0],
      );
    });
  }

  Future<void> saveEstadoVia(
    SyncStarted event,
    EstadoViaEntity estadoVia,
  ) async {
    final result = await estadoViaUsecaseDB.saveEstadoViaUsecase(estadoVia);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= estadosViasTemp.length) {
        ConnectionSQLiteService.truncateTable('MediosComunicacion')
            .then((value) async {
          mediosComunicacionTemp = [];
          await syncMediosComunicacion(event);
        });
        return;
      }

      EstadoViaEntity estadoViaTemp = estadosViasTemp[data];

      await saveEstadoVia(
        event,
        estadoViaTemp,
      );
    });
  }

// ************************** Estado Vias ****************************

// ************************** Medios comunicacion ****************************

  Future<void> syncMediosComunicacion(SyncStarted event) async {
    final result =
        await medioComunicacionUsecase.getMediosComunicacionUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      mediosComunicacionTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios comunicación',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveMedioComunicacion(
        event,
        mediosComunicacionTemp[0],
      );
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
      if (data >= mediosComunicacionTemp.length) {
        ConnectionSQLiteService.truncateTable('MediosUtiliza_CentroAtencion')
            .then((value) async {
          mediosUtilizaCATemp = [];
          await syncMediosUtilizaCA(event);
        });
        return;
      }

      MedioComunicacionEntity medioComunicacionTemp =
          mediosComunicacionTemp[data];

      await saveMedioComunicacion(
        event,
        medioComunicacionTemp,
      );
    });
  }

// ************************** Medios comunicacion ****************************

// ************************** Medios utiliza CA ****************************

  Future<void> syncMediosUtilizaCA(SyncStarted event) async {
    final result = await medioUtilizaCAUsecase.getMediosUtilizaCAUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      mediosUtilizaCATemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando medios utiliza centro atención',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveMedioUtilizaCA(
        event,
        mediosUtilizaCATemp[0],
      );
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
      if (data >= mediosUtilizaCATemp.length) {
        ConnectionSQLiteService.truncateTable('TiemposTarda_CentroAtencion')
            .then((value) async {
          tiemposTardaCATemp = [];
          await syncTiemposTardaCA(event);
        });
        return;
      }

      MedioUtilizaCAEntity medioUtilizaCATemp = mediosUtilizaCATemp[data];

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
          total: totalAccesories)));

      await saveTiemposTardaCA(
        event,
        tiemposTardaCATemp[0],
      );
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
      if (data >= tiemposTardaCATemp.length) {
        ConnectionSQLiteService.truncateTable('ViasAcceso').then((value) async {
          viasAccesoTemp = [];
          await syncViasAcceso(event);
        });
        return;
      }

      TiempoTardaCAEntity tiempoTardaCATemp = tiemposTardaCATemp[data];

      await saveTiemposTardaCA(
        event,
        tiempoTardaCATemp,
      );
    });
  }

// ************************** Tiempos tarda CA ****************************

// ************************** Via acceso ****************************

  Future<void> syncViasAcceso(SyncStarted event) async {
    final result = await viaAccesoUsecase.getViasAccesoUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      viasAccesoTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando vias acceso',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveViaAcceso(
        event,
        viasAccesoTemp[0],
      );
    });
  }

  Future<void> saveViaAcceso(
    SyncStarted event,
    ViaAccesoEntity viaAcceso,
  ) async {
    final result = await viaAccesoUsecaseDB.saveViaAccesoUsecaseDB(viaAcceso);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= viasAccesoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'AutoridadesIndigenas_DatosVivienda')
            .then((value) async {
          autoridadesIndigenasTemp = [];
          await syncAutoridadesIndigenas(event);
        });
        return;
      }

      ViaAccesoEntity viaAccesoTemp = viasAccesoTemp[data];

      await saveViaAcceso(
        event,
        viaAccesoTemp,
      );
    });
  }

// ************************** Via acceso ****************************

// ************************** AutoridadIndigena ****************************

  Future<void> syncAutoridadesIndigenas(SyncStarted event) async {
    final result =
        await autoridadIndigenaUsecase.getAutoridadesIndigenasUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      autoridadesIndigenasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando autoridades indígenas',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveAutoridadIndigena(
        event,
        autoridadesIndigenasTemp[0],
      );
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
      if (data >= autoridadesIndigenasTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Cereales_AspectosSocioEconomicos')
            .then((value) async {
          cerealesTemp = [];
          await syncCereales(event);
        });
        return;
      }

      AutoridadIndigenaEntity autoridadIndigenaTemp =
          autoridadesIndigenasTemp[data];

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
          total: totalAccesories)));

      await saveCereal(
        event,
        cerealesTemp[0],
      );
    });
  }

  Future<void> saveCereal(
    SyncStarted event,
    CerealEntity cereal,
  ) async {
    final result = await cerealUsecaseDB.saveCerealUsecaseDB(cereal);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= cerealesTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'CostosDesplazamiento_CentroAtencion')
            .then((value) async {
          costosDesplazamientoTemp = [];
          await syncCostosDesplazamiento(event);
        });
        return;
      }

      CerealEntity cerealTemp = cerealesTemp[data];

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
          total: totalAccesories)));

      await saveCostoDesplazamiento(
        event,
        costosDesplazamientoTemp[0],
      );
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
      if (data >= costosDesplazamientoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'DificultadesAcceso_AccesoMedTradicional')
            .then((value) async {
          dificultadesAccesoMedTradicionalTemp = [];
          await syncDificultadesAccesoMedTradicional(event);
        });
        return;
      }

      CostoDesplazamientoEntity costoDesplazamientoTemp =
          costosDesplazamientoTemp[data];

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
          total: totalAccesories)));

      await saveDificultadAccesoMedTradicional(
        event,
        dificultadesAccesoMedTradicionalTemp[0],
      );
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
      if (data >= dificultadesAccesoMedTradicionalTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'EspecialidadesMedTrad_AccesoMedTradicional')
            .then((value) async {
          especialidadesMedTradicionalTemp = [];
          await syncEspecialidadesMedTradicional(event);
        });
        return;
      }

      DificultadAccesoMedTradicionalEntity dificultadAccesoMedTradicionalTemp =
          dificultadesAccesoMedTradicionalTemp[data];

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
          total: totalAccesories)));

      await saveEspecialidadMedTradicional(
        event,
        especialidadesMedTradicionalTemp[0],
      );
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
      if (data >= especialidadesMedTradicionalTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'EspecieAnimalesCria_AspectosSocioEconomicos')
            .then((value) async {
          especiesAnimalesTemp = [];
          await syncEspeciesAnimales(event);
        });
        return;
      }

      EspecialidadMedTradicionalEntity e =
          especialidadesMedTradicionalTemp[data];

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
          total: totalAccesories)));

      await saveEspecieAnimal(
        event,
        especiesAnimalesTemp[0],
      );
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
      if (data >= especiesAnimalesTemp.length) {
        ConnectionSQLiteService.truncateTable('Frutos_AspectosSocioEconomicos')
            .then((value) async {
          frutosTemp = [];
          await syncFrutos(event);
        });
        return;
      }

      EspecieAnimalEntity especieAnimalTemp = especiesAnimalesTemp[data];

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
          total: totalAccesories)));

      await saveFruto(
        event,
        frutosTemp[0],
      );
    });
  }

  Future<void> saveFruto(
    SyncStarted event,
    FrutoEntity fruto,
  ) async {
    final result = await frutoUsecaseDB.saveFrutoUsecaseDB(fruto);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= frutosTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Hortalizas_AspectosSocioEconomicos')
            .then((value) async {
          hortalizasTemp = [];
          await syncHortalizas(event);
        });
        return;
      }

      FrutoEntity frutoTemp = frutosTemp[data];

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
          total: totalAccesories)));

      await saveHortaliza(
        event,
        hortalizasTemp[0],
      );
    });
  }

  Future<void> saveHortaliza(
    SyncStarted event,
    HortalizaEntity hortaliza,
  ) async {
    final result = await hortalizaUsecaseDB.saveHortalizaUsecaseDB(hortaliza);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= hortalizasTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Leguminosas_AspectosSocioEconomicos')
            .then((value) async {
          leguminosasTemp = [];
          await syncLeguminosas(event);
        });
        return;
      }

      HortalizaEntity hortalizaTemp = hortalizasTemp[data];

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
          total: totalAccesories)));

      await saveLeguminosa(
        event,
        leguminosasTemp[0],
      );
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
      if (data >= leguminosasTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'MediosUtiliza_AccesoMedTradicional')
            .then((value) async {
          mediosUtilizaMedTradicionalTemp = [];
          await syncMediosUtilizaMedTradicional(event);
        });
        return;
      }

      LeguminosaEntity leguminosaTemp = leguminosasTemp[data];

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
          total: totalAccesories)));

      await saveMedioUtilizaMedTradicional(
        event,
        mediosUtilizaMedTradicionalTemp[0],
      );
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
      if (data >= mediosUtilizaMedTradicionalTemp.length) {
        ConnectionSQLiteService.truncateTable('OpcionesSi_No')
            .then((value) async {
          opcionesSiNoTemp = [];
          await syncOpcionesSiNo(event);
        });
        return;
      }

      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicionalTemp =
          mediosUtilizaMedTradicionalTemp[data];

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
          total: totalAccesories)));

      await saveOpcionSiNo(
        event,
        opcionesSiNoTemp[0],
      );
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
      if (data >= opcionesSiNoTemp.length) {
        //TODO: TEMP UNTIL FIXING
        ConnectionSQLiteService.truncateTable(
                'TiemposTarda_AccesoMedTradicional')
            .then((value) async {
          tiemposTardaMedTradicionalTemp = [];
          await syncTiemposTardaMedTradicional(event);
        });
        return;
        /* ConnectionSQLiteService.truncateTable('Resguardos').then((value) async {
          resguardosTemp = [];
          await syncResguardos(event);
        }); 
        return;
        */
      }

      OpcionSiNoEntity opcionSiNoTemp = opcionesSiNoTemp[data];

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
          total: totalAccesories)));

      await saveResguardo(
        event,
        resguardosTemp[0],
      );
    });
  }

  Future<void> saveResguardo(
    SyncStarted event,
    ResguardoEntity resguardo,
  ) async {
    final result = await resguardoUsecaseDB.saveResguardoUsecaseDB(resguardo);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= resguardosTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TiemposTarda_AccesoMedTradicional')
            .then((value) async {
          tiemposTardaMedTradicionalTemp = [];
          await syncTiemposTardaMedTradicional(event);
        });
        return;
      }

      ResguardoEntity resguardoTemp = resguardosTemp[data];

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
          total: totalAccesories)));

      await saveTiempoTardaMedTradicional(
        event,
        tiemposTardaMedTradicionalTemp[0],
      );
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
      if (data >= tiemposTardaMedTradicionalTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TuberculosPlatanos_AspectosSocioEconomicos')
            .then((value) async {
          tuberculosPlatanosTemp = [];
          await syncTuberculosPlatanos(event);
        });
        return;
      }

      TiempoTardaMedTradicionalEntity tiempoTardaMedTradicionalTemp =
          tiemposTardaMedTradicionalTemp[data];

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
          total: totalAccesories)));

      await saveTuberculoPlatano(
        event,
        tuberculosPlatanosTemp[0],
      );
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
      if (data >= tuberculosPlatanosTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Verduras_AspectosSocioEconomicos')
            .then((value) async {
          verdurasTemp = [];
          await syncVerduras(event);
        });
        return;
      }

      TuberculoPlatanoEntity tuberculoPlatanoTemp =
          tuberculosPlatanosTemp[data];

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
          total: totalAccesories)));

      await saveVerdura(
        event,
        verdurasTemp[0],
      );
    });
  }

  Future<void> saveVerdura(
    SyncStarted event,
    VerduraEntity verdura,
  ) async {
    final result = await verduraUsecaseDB.saveVerduraUsecaseDB(verdura);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= verdurasTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'FactoresRiesgoVivienda_DatosVivienda')
            .then((value) async {
          factoresRiesgoViviendaTemp = [];
          await syncFactoresRiesgoVivienda(event);
        });
        return;
      }

      VerduraEntity verduraTemp = verdurasTemp[data];

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
          total: totalAccesories)));

      await saveFactorRiesgoVivienda(
        event,
        factoresRiesgoViviendaTemp[0],
      );
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
      if (data >= factoresRiesgoViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'IluminacionVivienda_DatosVivienda')
            .then((value) async {
          iluminacionesViviendaTemp = [];
          await syncIluminacionesVivienda(event);
        });
        return;
      }

      FactorRiesgoViviendaEntity factorRiesgoViviendaTemp =
          factoresRiesgoViviendaTemp[data];

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
          total: totalAccesories)));

      await saveIluminacionVivienda(
        event,
        iluminacionesViviendaTemp[0],
      );
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
      if (data >= iluminacionesViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable('PisosVivienda_DatosVivienda')
            .then((value) async {
          pisosViviendaTemp = [];
          await syncPisosVivienda(event);
        });
        return;
      }

      IluminacionViviendaEntity iluminacionViviendaTemp =
          iluminacionesViviendaTemp[data];

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
          total: totalAccesories)));

      await savePisoVivienda(
        event,
        pisosViviendaTemp[0],
      );
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
      if (data >= pisosViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'PresenciaAnimalesVivienda_DatosVivienda')
            .then((value) async {
          presenciaAnimalesViviendaTemp = [];
          await syncPresenciaAnimalesVivienda(event);
        });
        return;
      }

      PisoViviendaEntity pisoViviendaTemp = pisosViviendaTemp[data];

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
          total: totalAccesories)));

      await savePresenciaAnimalVivienda(
        event,
        presenciaAnimalesViviendaTemp[0],
      );
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
      if (data >= presenciaAnimalesViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'ServiciosPublicosVivienda_DatosVivienda')
            .then((value) async {
          serviciosPublicosViviendaTemp = [];
          await syncServiciosPublicosVivienda(event);
        });
        return;
      }

      PresenciaAnimalViviendaEntity presenciaAnimalViviendaTemp =
          presenciaAnimalesViviendaTemp[data];

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
          total: totalAccesories)));

      await saveServicioPublicoVivienda(
        event,
        serviciosPublicosViviendaTemp[0],
      );
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
      if (data >= serviciosPublicosViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable('TechosVivienda_DatosVivienda')
            .then((value) async {
          techosViviendaTemp = [];
          await syncTechosVivienda(event);
        });
        return;
      }

      ServicioPublicoViviendaEntity servicioPublicoViviendaTemp =
          serviciosPublicosViviendaTemp[data];

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
          total: totalAccesories)));

      await saveTechoVivienda(
        event,
        techosViviendaTemp[0],
      );
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
      if (data >= techosViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable('TenenciasVivienda_DatosVivienda')
            .then((value) async {
          tenenciasViviendaTemp = [];
          await syncTenenciasVivienda(event);
        });
        return;
      }

      TechoViviendaEntity techoViviendaTemp = techosViviendaTemp[data];

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
          total: totalAccesories)));

      await saveTenenciaVivienda(
        event,
        tenenciasViviendaTemp[0],
      );
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
      if (data >= tenenciasViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TiposCombustibleVivienda_DatosVivienda')
            .then((value) async {
          tiposCombustibleViviendaTemp = [];
          await syncTiposCombustibleVivienda(event);
        });
        return;
      }

      TenenciaViviendaEntity tenenciaViviendaTemp = tenenciasViviendaTemp[data];

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
          total: totalAccesories)));

      await saveTipoCombustibleVivienda(
        event,
        tiposCombustibleViviendaTemp[0],
      );
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
      if (data >= tiposCombustibleViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TiposSanitarioVivienda_DatosVivienda')
            .then((value) async {
          tiposSanitarioViviendaTemp = [];
          await syncTiposSanitarioVivienda(event);
        });
        return;
      }

      TipoCombustibleViviendaEntity tipoCombustibleViviendaTemp =
          tiposCombustibleViviendaTemp[data];

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
          total: totalAccesories)));

      await saveTipoSanitarioVivienda(
        event,
        tiposSanitarioViviendaTemp[0],
      );
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
      if (data >= tiposSanitarioViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TratamientoAguaVivienda_DatosVivienda')
            .then((value) async {
          tratamientosAguaViviendaTemp = [];
          await syncTratamientosAguaVivienda(event);
        });
        return;
      }

      TipoSanitarioViviendaEntity tipoSanitarioViviendaTemp =
          tiposSanitarioViviendaTemp[data];

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
          total: totalAccesories)));

      await saveTratamientoAguaVivienda(
        event,
        tratamientosAguaViviendaTemp[0],
      );
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
      if (data >= tratamientosAguaViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'VentilacionVivienda_DatosVivienda')
            .then((value) async {
          ventilacionesViviendaTemp = [];
          await syncVentilacionesVivienda(event);
        });
        return;
      }

      TratamientoAguaViviendaEntity tratamientoAguaViviendaTemp =
          tratamientosAguaViviendaTemp[data];

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
          total: totalAccesories)));

      await saveVentilacionVivienda(
        event,
        ventilacionesViviendaTemp[0],
      );
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
      if (data >= ventilacionesViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable('TiposVivienda_DatosVivienda')
            .then((value) async {
          tiposViviendaTemp = [];
          await syncTiposVivienda(event);
        });
        return;
      }

      VentilacionViviendaEntity ventilacionViviendaTemp =
          ventilacionesViviendaTemp[data];

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
          total: totalAccesories)));

      await saveTipoVivienda(
        event,
        tiposViviendaTemp[0],
      );
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
      if (data >= tiposViviendaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'TiposCalendarios_AspectosSocioEconomicos')
            .then((value) async {
          tiposCalendarioTemp = [];
          await syncTiposCalendario(event);
        });
        return;
      }

      TipoViviendaEntity tipoViviendaTemp = tiposViviendaTemp[data];

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
          total: totalAccesories)));

      await saveTipoCalendario(
        event,
        tiposCalendarioTemp[0],
      );
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
      if (data >= tiposCalendarioTemp.length) {
        ConnectionSQLiteService.truncateTable('CursoVida_GrupoFamiliar')
            .then((value) async {
          cursosVidaTemp = [];
          await syncCursosVida(event);
        });
        return;
      }

      TipoCalendarioEntity tipoCalendarioTemp = tiposCalendarioTemp[data];

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
          total: totalAccesories)));

      await saveCursoVida(
        event,
        cursosVidaTemp[0],
      );
    });
  }

  Future<void> saveCursoVida(
    SyncStarted event,
    CursoVidaEntity cursoVida,
  ) async {
    final result = await cursoVidaUsecaseDB.saveCursoVidaUsecaseDB(cursoVida);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= cursosVidaTemp.length) {
        ConnectionSQLiteService.truncateTable('Etnia_GrupoFamiliar')
            .then((value) async {
          etniasTemp = [];
          await syncEtnias(event);
        });
        return;
      }

      CursoVidaEntity cursoVidaTemp = cursosVidaTemp[data];

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
          total: totalAccesories)));

      await saveEtnia(
        event,
        etniasTemp[0],
      );
    });
  }

  Future<void> saveEtnia(
    SyncStarted event,
    EtniaEntity etnia,
  ) async {
    final result = await etniaUsecaseDB.saveEtniaUsecaseDB(etnia);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= etniasTemp.length) {
        ConnectionSQLiteService.truncateTable('Genero_GrupoFamiliar')
            .then((value) async {
          generosTemp = [];
          await syncGeneros(event);
        });
        return;
      }

      EtniaEntity etniaTemp = etniasTemp[data];

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
          total: totalAccesories)));

      await saveGenero(
        event,
        generosTemp[0],
      );
    });
  }

  Future<void> saveGenero(
    SyncStarted event,
    GeneroEntity genero,
  ) async {
    final result = await generoUsecaseDB.saveGeneroUsecaseDB(genero);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= generosTemp.length) {
        ConnectionSQLiteService.truncateTable('GrupoRiesgo_GrupoFamiliar')
            .then((value) async {
          gruposRiesgoTemp = [];
          await syncGruposRiesgo(event);
        });
        return;
      }

      GeneroEntity generoTemp = generosTemp[data];

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
          total: totalAccesories)));

      await saveGrupoRiesgo(
        event,
        gruposRiesgoTemp[0],
      );
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
      if (data >= gruposRiesgoTemp.length) {
        ConnectionSQLiteService.truncateTable('LenguaManeja_GrupoFamiliar')
            .then((value) async {
          lenguasManejaTemp = [];
          await syncLenguasManeja(event);
        });
        return;
      }

      GrupoRiesgoEntity grupoRiesgoTemp = gruposRiesgoTemp[data];

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
          total: totalAccesories)));

      await saveLenguaManeja(
        event,
        lenguasManejaTemp[0],
      );
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
      if (data >= lenguasManejaTemp.length) {
        ConnectionSQLiteService.truncateTable('NivelEducativo_GrupoFamiliar')
            .then((value) async {
          nivelesEducativosTemp = [];
          await syncNivelesEducativos(event);
        });
        return;
      }
      LenguaManejaEntity lenguaManejaTemp = lenguasManejaTemp[data];

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
          total: totalAccesories)));

      await saveNivelEducativo(
        event,
        nivelesEducativosTemp[0],
      );
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
      if (data >= nivelesEducativosTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'NombreLenguaMaterna_GrupoFamiliar')
            .then((value) async {
          nombresLenguasMaternaTemp = [];
          await syncNombresLenguasMaterna(event);
        });
        return;
      }
      NivelEducativoEntity nivelEducativoTemp = nivelesEducativosTemp[data];

      await saveNivelEducativo(
        event,
        nivelEducativoTemp,
      );
    });
  }

// ************************** NivelesEducativos ****************************

// ************************** NombresLenguasMaterna ****************************

  Future<void> syncNombresLenguasMaterna(SyncStarted event) async {
    final result =
        await nombreLenguaMaternaUsecase.getNombresLenguasMaternaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      nombresLenguasMaternaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando nombres lenguas maternas',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveNombreLenguaMaterna(
        event,
        nombresLenguasMaternaTemp[0],
      );
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
      if (data >= nombresLenguasMaternaTemp.length) {
        ConnectionSQLiteService.truncateTable('Ocupacion_GrupoFamiliar')
            .then((value) async {
          ocupacionesTemp = [];
          await syncOcupaciones(event);
        });
        return;
      }
      NombreLenguaMaternaEntity nombreLenguaMaternaTemp =
          nombresLenguasMaternaTemp[data];

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
          total: totalAccesories)));

      await saveOcupacion(
        event,
        ocupacionesTemp[0],
      );
    });
  }

  Future<void> saveOcupacion(
    SyncStarted event,
    OcupacionEntity ocupacion,
  ) async {
    final result = await ocupacionUsecaseDB.saveOcupacionUsecaseDB(ocupacion);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= ocupacionesTemp.length) {
        ConnectionSQLiteService.truncateTable('Parentesco_GrupoFamiliar')
            .then((value) async {
          parentescosTemp = [];
          await syncParentescos(event);
        });
        return;
      }
      OcupacionEntity ocupacionTemp = ocupacionesTemp[data];

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
          total: totalAccesories)));

      await saveParentesco(
        event,
        parentescosTemp[0],
      );
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
      if (data >= parentescosTemp.length) {
        ConnectionSQLiteService.truncateTable('PueblosIndigenas_GrupoFamiliar')
            .then((value) async {
          pueblosIndigenasTemp = [];
          await syncPueblosIndigenas(event);
        });
        return;
      }
      ParentescoEntity parentescoTemp = parentescosTemp[data];

      await saveParentesco(
        event,
        parentescoTemp,
      );
    });
  }

// ************************** Parentescos ****************************

// ************************** PueblosIndigenas ****************************

  Future<void> syncPueblosIndigenas(SyncStarted event) async {
    final result = await puebloIndigenaUsecase.getPueblosIndigenasUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      pueblosIndigenasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando pueblos indigenas',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await savePuebloIndigena(
        event,
        pueblosIndigenasTemp[0],
      );
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
      if (data >= pueblosIndigenasTemp.length) {
        ConnectionSQLiteService.truncateTable('Regimenes_GrupoFamiliar')
            .then((value) async {
          regimenesTemp = [];
          await syncRegimenes(event);
        });
        return;
      }
      PuebloIndigenaEntity puebloIndigenaTemp = pueblosIndigenasTemp[data];

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
          total: totalAccesories)));

      await saveRegimen(
        event,
        regimenesTemp[0],
      );
    });
  }

  Future<void> saveRegimen(
    SyncStarted event,
    RegimenEntity regimen,
  ) async {
    final result = await regimenUsecaseDB.saveRegimenUsecaseDB(regimen);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= regimenesTemp.length) {
        ConnectionSQLiteService.truncateTable('TiposDocumento_GrupoFamiliar')
            .then((value) async {
          tiposDocumentoTemp = [];
          await syncTiposDocumento(event);
        });
        return;
      }
      RegimenEntity regimenTemp = regimenesTemp[data];

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
          total: totalAccesories)));

      await saveTipoDocumento(
        event,
        tiposDocumentoTemp[0],
      );
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
      if (data >= tiposDocumentoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'ActividadesFisicas_EstilosVidaSaludable')
            .then((value) async {
          actividadesFisicasTemp = [];
          await syncActividadesFisicas(event);
        });
        return;
      }
      TipoDocumentoEntity tipoDocumentoTemp = tiposDocumentoTemp[data];

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
          total: totalAccesories)));

      await saveActividadFisica(
        event,
        actividadesFisicasTemp[0],
      );
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
      if (data >= actividadesFisicasTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'Alimentacion_EstilosVidaSaludable')
            .then((value) async {
          alimentacionesTemp = [];
          await syncAlimentaciones(event);
        });
        return;
      }
      ActividadFisicaEntity actividadFisicaTemp = actividadesFisicasTemp[data];

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
          total: totalAccesories)));

      await saveAlimentacion(
        event,
        alimentacionesTemp[0],
      );
    });
  }

  Future<void> saveAlimentacion(
    SyncStarted event,
    AlimentacionEntity alimentacion,
  ) async {
    final result =
        await alimentacionUsecaseDB.saveAlimentacionUsecaseDB(alimentacion);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      if (data >= alimentacionesTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'NumeroCigarrilosDia_EstilosVidaSaludable')
            .then((value) async {
          cigarrillosDiaTemp = [];
          await syncCigarrillosDia(event);
        });
        return;
      }
      AlimentacionEntity alimentacionTemp = alimentacionesTemp[data];

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
          total: totalAccesories)));

      await saveCigarrilloDia(
        event,
        cigarrillosDiaTemp[0],
      );
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
      if (data >= cigarrillosDiaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'ConsumoAlcohol_EstilosVidaSaludable')
            .then((value) async {
          consumosAlcoholTemp = [];
          await syncConsumosAlcohol(event);
        });
        return;
      }
      CigarrilloDiaEntity cigarrilloDiaTemp = cigarrillosDiaTemp[data];

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
          total: totalAccesories)));

      await saveConsumoAlcohol(
        event,
        consumosAlcoholTemp[0],
      );
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
      if (data >= consumosAlcoholTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'CondicionesNutricionales_CuidadoSaludCondRiesgo')
            .then((value) async {
          condicionesNutricionalesTemp = [];
          await syncCondicionesNutricionales(event);
        });
        return;
      }
      ConsumoAlcoholEntity consumoAlcoholTemp = consumosAlcoholTemp[data];

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
          total: totalAccesories)));

      await saveCondicionNutricional(
        event,
        condicionesNutricionalesTemp[0],
      );
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
      if (data >= condicionesNutricionalesTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'ConductasSeguir_CuidadoSaludCondRiesgo')
            .then((value) async {
          conductasSeguirTemp = [];
          await syncConductasSeguir(event);
        });
        return;
      }
      CondicionNutricionalEntity condicionNutricionalTemp =
          condicionesNutricionalesTemp[data];

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
          total: totalAccesories)));

      await saveConductaSeguir(
        event,
        conductasSeguirTemp[0],
      );
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
      if (data >= conductasSeguirTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'EsquemasVacunacion_CuidadoSaludCondRiesgo')
            .then((value) async {
          esquemasVacunacionTemp = [];
          await syncEsquemasVacunacion(event);
        });
        return;
      }
      ConductaSeguirEntity conductaSeguirTemp = conductasSeguirTemp[data];

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
          total: totalAccesories)));

      await saveEsquemaVacunacion(
        event,
        esquemasVacunacionTemp[0],
      );
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
      if (data >= esquemasVacunacionTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'LugaresVacunacion_CuidadoSaludCondRiesgo')
            .then((value) async {
          lugaresVacunacionTemp = [];
          await syncLugaresVacunacion(event);
        });
        return;
      }
      EsquemaVacunacionEntity esquemaVacunacionTemp =
          esquemasVacunacionTemp[data];

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
          total: totalAccesories)));

      await saveLugarVacunacion(
        event,
        lugaresVacunacionTemp[0],
      );
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
      if (data >= lugaresVacunacionTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'MetodosPlanificacion_CuidadoSaludCondRiesgo')
            .then((value) async {
          metodosPlanificacionTemp = [];
          await syncMetodosPlanificacion(event);
        });
        return;
      }
      LugarVacunacionEntity lugarVacunacionTemp = lugaresVacunacionTemp[data];

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
          total: totalAccesories)));

      await saveMetodoPlanificacion(
        event,
        metodosPlanificacionTemp[0],
      );
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
      if (data >= metodosPlanificacionTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'NombresEnfermedad_CuidadoSaludCondRiesgo')
            .then((value) async {
          nombresEnfermedadesTemp = [];
          await syncNombresEnfermedades(event);
        });
        return;
      }
      MetodoPlanificacionEntity metodoPlanificacionTemp =
          metodosPlanificacionTemp[data];

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
          total: totalAccesories)));

      await saveNombreEnfermedad(
        event,
        nombresEnfermedadesTemp[0],
      );
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
      if (data >= nombresEnfermedadesTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'SeguimientoEnfermedades_CuidadoSaludCondRiesgo')
            .then((value) async {
          seguimientoEnfermedadesTemp = [];
          await syncSeguimientoEnfermedades(event);
        });
        return;
      }
      NombreEnfermedadEntity nombreEnfermedadTemp =
          nombresEnfermedadesTemp[data];

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
          total: totalAccesories)));

      await saveSeguimientoEnfermedad(
        event,
        seguimientoEnfermedadesTemp[0],
      );
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
      if (data >= seguimientoEnfermedadesTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'ServiciosSolicitados_CuidadoSaludCondRiesgo')
            .then((value) async {
          serviciosSolicitadosTemp = [];
          await syncServiciosSolicitados(event);
        });
        return;
      }
      SeguimientoEnfermedadEntity seguimientoEnfermedadTemp =
          seguimientoEnfermedadesTemp[data];

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
          total: totalAccesories)));

      await saveServicioSolicitado(
        event,
        serviciosSolicitadosTemp[0],
      );
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
      if (data >= serviciosSolicitadosTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'UltimaVezInstSalud_CuidadoSaludCondRiesgo')
            .then((value) async {
          ultimasVecesInstSaludTemp = [];
          await syncUltimasVecesInstSalud(event);
        });
        return;
      }
      ServicioSolicitadoEntity servicioSolicitadoTemp =
          serviciosSolicitadosTemp[data];

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
          total: totalAccesories)));

      await saveUltimaVezInstSalud(
        event,
        ultimasVecesInstSaludTemp[0],
      );
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
      if (data >= ultimasVecesInstSaludTemp.length) {
        ConnectionSQLiteService.truncateTable('EnfermedadesAcude_AtencionSalud')
            .then((value) async {
          enfermedadesAcudeTemp = [];
          await syncEnfermedadesAcude(event);
        });
        return;
      }
      UltimaVezInstSaludEntity ultimaVezInstSaludTemp =
          ultimasVecesInstSaludTemp[data];

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
          total: totalAccesories)));

      await saveEnfermedadAcude(
        event,
        enfermedadesAcudeTemp[0],
      );
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
      if (data >= enfermedadesAcudeTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'EnfermedadesTratamientos_AtencionSalud')
            .then((value) async {
          enfermedadesTratamientoTemp = [];
          await syncEnfermedadesTratamiento(event);
        });
        return;
      }
      EnfermedadAcudeEntity enfermedadAcudeTemp = enfermedadesAcudeTemp[data];

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
          total: totalAccesories)));

      await saveEnfermedadTratamiento(
        event,
        enfermedadesTratamientoTemp[0],
      );
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
      if (data >= enfermedadesTratamientoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'EnfermedadesTradicionales_AtencionSalud')
            .then((value) async {
          enfermedadesTradicionalesTemp = [];
          await syncEnfermedadesTradicionales(event);
        });
        return;
      }
      EnfermedadTratamientoEntity enfermedadTratamientoTemp =
          enfermedadesTratamientoTemp[data];

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
        .getEnfermedadesTradicionalesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      enfermedadesTradicionalesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando enfermedades tradicionales',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveEnfermedadTradicional(
        event,
        enfermedadesTradicionalesTemp[0],
      );
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
      if (data >= enfermedadesTradicionalesTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'LugaresAtencionMedico_AtencionSalud')
            .then((value) async {
          lugaresAtencionMedicoTemp = [];
          await syncLugaresAtencionMedico(event);
        });
        return;
      }
      EnfermedadTradicionalEntity enfermedadTradicionalTemp =
          enfermedadesTradicionalesTemp[data];

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
          total: totalAccesories)));

      await saveLugarAtencionMedico(
        event,
        lugaresAtencionMedicoTemp[0],
      );
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
      if (data >= lugaresAtencionMedicoTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'LugaresPlantasMedicinales_AtencionSalud')
            .then((value) async {
          lugaresPlantasMedicinalesTemp = [];
          await syncLugaresPlantasMedicinales(event);
        });
        return;
      }
      LugarAtencionMedicoEntity lugarAtencionMedicoTemp =
          lugaresAtencionMedicoTemp[data];

      await saveLugarAtencionMedico(
        event,
        lugarAtencionMedicoTemp,
      );
    });
  }

// ************************** LugaresAtencionMedico ****************************

// ************************** LugaresPlantasMedicinales ****************************

  Future<void> syncLugaresPlantasMedicinales(SyncStarted event) async {
    final result =
        await lugarPlantaMedicinalUsecase.getLugaresPlantasMedicinalesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      lugaresPlantasMedicinalesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando lugares plantas medicinales',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveLugarPlantaMedicinal(
        event,
        lugaresPlantasMedicinalesTemp[0],
      );
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
      if (data >= lugaresPlantasMedicinalesTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'PlantasMedicinales_AtencionSalud')
            .then((value) async {
          plantasMedicinalesTemp = [];
          await syncPlantasMedicinales(event);
        });
        return;
      }
      LugarPlantaMedicinalEntity lugarPlantaMedicinalTemp =
          lugaresPlantasMedicinalesTemp[data];

      await saveLugarPlantaMedicinal(
        event,
        lugarPlantaMedicinalTemp,
      );
    });
  }

// ************************** LugaresPlantasMedicinales ****************************

// ************************** PlantasMedicinales ****************************

  Future<void> syncPlantasMedicinales(SyncStarted event) async {
    final result = await plantaMedicinalUsecase.getPlantasMedicinalesUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      plantasMedicinalesTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando plantas medicinales',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await savePlantaMedicinal(
        event,
        plantasMedicinalesTemp[0],
      );
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
      if (data >= plantasMedicinalesTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'ReligionesProfesa_DimSocioCulturalPueblosIndigenas')
            .then((value) async {
          religionesProfesaTemp = [];
          await syncReligionesProfesa(event);
        });
        return;
      }
      PlantaMedicinalEntity plantaMedicinalTemp = plantasMedicinalesTemp[data];

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
          total: totalAccesories)));

      await saveReligionProfesa(
        event,
        religionesProfesaTemp[0],
      );
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
      if (data >= religionesProfesaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas')
            .then((value) async {
          eventosCostumbresParticipaTemp = [];
          await syncEventosCostumbresParticipa(event);
        });
        return;
      }
      ReligionProfesaEntity religionProfesaTemp = religionesProfesaTemp[data];

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
        .getEventosCostumbresParticipaUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      eventosCostumbresParticipaTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando eventos costumbres participa',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveEventoCostumbreParticipa(
        event,
        eventosCostumbresParticipaTemp[0],
      );
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
      if (data >= eventosCostumbresParticipaTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'CostumbresPractican_DimSocioCulturalPueblosIndigenas')
            .then((value) async {
          costumbresPracticanTemp = [];
          await syncCostumbresPractican(event);
        });
        return;
      }
      EventoCostumbreParticipaEntity eventoCostumbreParticipaTemp =
          eventosCostumbresParticipaTemp[data];

      await saveEventoCostumbreParticipa(
        event,
        eventoCostumbreParticipaTemp,
      );
    });
  }

// ************************** EventosCostumbresParticipa ****************************

// ************************** CostumbresPractican ****************************

  Future<void> syncCostumbresPractican(SyncStarted event) async {
    final result =
        await costumbrePracticaUsecase.getCostumbresPracticanUsecase();
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      costumbresPracticanTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando eventos costumbres participa',
          counter: state.syncProgressModel.counter + 1,
          total: totalAccesories)));

      await saveCostumbrePractica(
        event,
        costumbresPracticanTemp[0],
      );
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
      if (data >= costumbresPracticanTemp.length) {
        ConnectionSQLiteService.truncateTable(
                'SancionesJusticia_DimSocioCulturalPueblosIndigenas')
            .then((value) async {
          sancionesJusticiaTemp = [];
          await syncSancionesJusticia(event);
        });
        return;
      }
      CostumbrePracticaEntity costumbrePracticaTemp =
          costumbresPracticanTemp[data];

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
          total: totalAccesories)));

      await saveSancionJusticia(
        event,
        sancionesJusticiaTemp[0],
      );
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
      if (data >= sancionesJusticiaTemp.length) {
        add(SyncIncrementChanged(state.syncProgressModel.copyWith(
            title: 'Sincronización completada',
            counter: state.syncProgressModel.counter + 1,
            total: totalAccesories)));
        return;
      }
      SancionJusticiaEntity sancionJusticiaTemp = sancionesJusticiaTemp[data];

      await saveSancionJusticia(
        event,
        sancionJusticiaTemp,
      );
    });
  }

// ************************** SancionesJusticia ****************************

  int calculatePercent() {
    final counter = state.syncProgressModel.counter <= 0
        ? 0.01
        : state.syncProgressModel.counter;
    final total =
        state.syncProgressModel.total <= 0 ? 1 : state.syncProgressModel.total;
    final percent = ((counter / total) * 100).toInt();

    return percent;
  }
}
