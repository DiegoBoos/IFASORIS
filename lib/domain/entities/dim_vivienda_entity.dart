import '../../data/models/factor_riesgo_vivienda_model.dart';
import '../../data/models/piso_vivienda_model.dart';
import '../../data/models/presencia_animal_vivienda_model.dart';
import '../../data/models/servicio_publico_vivienda_model.dart';
import '../../data/models/techo_vivienda_model.dart';
import '../../data/models/tipo_combustible_vivienda_model.dart';
import '../../data/models/tipo_sanitario_vivienda_model.dart';
import '../../data/models/tratamiento_agua_vivienda_model.dart';
import '../../ui/blocs/dim_vivienda/dim_vivienda_bloc.dart';

class DimViviendaEntity {
  int? datoViviendaId;
  int? familiaId;
  int? tipoViviendaId;
  int? tenenciaViviendaId;
  int? ventilacionViviendaId;
  int? iluminacionViviendaId;
  int? nroCuartosViviendaId;
  List<LstPiso>? lstPiso;
  List<LstTecho>? lstTecho;
  List<LstServPublico>? lstServPublico;
  List<LstTmtoAgua>? lstTmtoAgua;
  List<LstFactorRiesgo>? lstFactorRiesgo;
  List<LstTipoSanitario>? lstTipoSanitario;
  List<LstTipoCombustible>? lstTipoCombustible;
  List<LstPresenciaAnimal>? lstPresenciaAnimal;
  DimViviendaState formStatus;

  DimViviendaEntity({
    this.datoViviendaId,
    this.familiaId,
    this.tipoViviendaId,
    this.tenenciaViviendaId,
    this.ventilacionViviendaId,
    this.iluminacionViviendaId,
    this.nroCuartosViviendaId,
    this.lstPiso,
    this.lstTecho,
    this.lstServPublico,
    this.lstTmtoAgua,
    this.lstFactorRiesgo,
    this.lstTipoSanitario,
    this.lstTipoCombustible,
    this.lstPresenciaAnimal,
    this.formStatus = const DimViviendaFormInitial(),
  });

  DimViviendaEntity copyWith(
          {int? datoViviendaId,
          int? familiaId,
          int? tipoViviendaId,
          int? tenenciaViviendaId,
          int? ventilacionViviendaId,
          int? iluminacionViviendaId,
          int? nroCuartosViviendaId,
          List<LstPiso>? lstPiso,
          List<LstTecho>? lstTecho,
          List<LstServPublico>? lstServPublico,
          List<LstTmtoAgua>? lstTmtoAgua,
          List<LstFactorRiesgo>? lstFactorRiesgo,
          List<LstTipoSanitario>? lstTipoSanitario,
          List<LstTipoCombustible>? lstTipoCombustible,
          List<LstPresenciaAnimal>? lstPresenciaAnimal,
          DimViviendaState? formStatus}) =>
      DimViviendaEntity(
        datoViviendaId: datoViviendaId ?? this.datoViviendaId,
        familiaId: familiaId ?? this.familiaId,
        tipoViviendaId: tipoViviendaId ?? this.tipoViviendaId,
        tenenciaViviendaId: tenenciaViviendaId ?? this.tenenciaViviendaId,
        ventilacionViviendaId:
            ventilacionViviendaId ?? this.ventilacionViviendaId,
        iluminacionViviendaId:
            iluminacionViviendaId ?? this.iluminacionViviendaId,
        nroCuartosViviendaId: nroCuartosViviendaId ?? this.nroCuartosViviendaId,
        lstPiso: lstPiso ?? this.lstPiso,
        lstTecho: lstTecho ?? this.lstTecho,
        lstServPublico: lstServPublico ?? this.lstServPublico,
        lstTmtoAgua: lstTmtoAgua ?? this.lstTmtoAgua,
        lstFactorRiesgo: lstFactorRiesgo ?? this.lstFactorRiesgo,
        lstTipoSanitario: lstTipoSanitario ?? this.lstTipoSanitario,
        lstTipoCombustible: lstTipoCombustible ?? this.lstTipoCombustible,
        lstPresenciaAnimal: lstPresenciaAnimal ?? this.lstPresenciaAnimal,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "Familia_id": familiaId,
        "TipoVivienda_id": tipoViviendaId,
        "TenenciaVivienda_id": tenenciaViviendaId,
        "VentilacionVivienda_id": ventilacionViviendaId,
        "IluminacionVivienda_id": iluminacionViviendaId,
        "NroCuartosVivienda_id": nroCuartosViviendaId,
      };
}
