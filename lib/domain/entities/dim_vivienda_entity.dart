import '../../data/models/factor_riesgo_vivienda_model.dart';
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
  /*  int? iluminacionViviendaId; */
  int? pisoViviendaId;
  String? otroTipoPiso;
  List<LstTecho>? lstTechos;
  List<LstServPublico>? lstServPublicos;
  List<LstTmtoAgua>? lstTmtoAguas;
  List<LstFactoresRiesgo>? lstFactoresRiesgo;
  List<LstTiposSanitario>? lstTiposSanitario;
  List<LstTiposCombustible>? lstTiposCombustible;
  List<LstPresenciaAnimal>? lstPresenciaAnimales;
  DimViviendaState formStatus;
  int? remoteViviendaId;

  DimViviendaEntity({
    this.datoViviendaId,
    this.familiaId,
    this.tipoViviendaId,
    this.tenenciaViviendaId,
    this.ventilacionViviendaId,
    /*  this.iluminacionViviendaId, */
    this.pisoViviendaId,
    this.otroTipoPiso,
    this.lstTechos,
    this.lstServPublicos,
    this.lstTmtoAguas,
    this.lstFactoresRiesgo,
    this.lstTiposSanitario,
    this.lstTiposCombustible,
    this.lstPresenciaAnimales,
    this.formStatus = const DimViviendaFormInitial(),
    this.remoteViviendaId,
  });

  DimViviendaEntity copyWith(
          {int? datoViviendaId,
          int? familiaId,
          int? tipoViviendaId,
          int? tenenciaViviendaId,
          int? ventilacionViviendaId,
          /*  int? iluminacionViviendaId, */
          int? pisoViviendaId,
          String? otroTipoPiso,
          List<LstTecho>? lstTechos,
          List<LstServPublico>? lstServPublicos,
          List<LstTmtoAgua>? lstTmtoAguas,
          List<LstFactoresRiesgo>? lstFactoresRiesgo,
          List<LstTiposSanitario>? lstTiposSanitario,
          List<LstTiposCombustible>? lstTiposCombustible,
          List<LstPresenciaAnimal>? lstPresenciaAnimales,
          DimViviendaState? formStatus}) =>
      DimViviendaEntity(
        datoViviendaId: datoViviendaId ?? this.datoViviendaId,
        familiaId: familiaId ?? this.familiaId,
        tipoViviendaId: tipoViviendaId ?? this.tipoViviendaId,
        tenenciaViviendaId: tenenciaViviendaId ?? this.tenenciaViviendaId,
        ventilacionViviendaId:
            ventilacionViviendaId ?? this.ventilacionViviendaId,
        /*   iluminacionViviendaId:
            iluminacionViviendaId ?? this.iluminacionViviendaId, */
        pisoViviendaId: pisoViviendaId ?? this.pisoViviendaId,
        otroTipoPiso: otroTipoPiso ?? this.otroTipoPiso,
        lstTechos: lstTechos ?? this.lstTechos,
        lstServPublicos: lstServPublicos ?? this.lstServPublicos,
        lstTmtoAguas: lstTmtoAguas ?? this.lstTmtoAguas,
        lstFactoresRiesgo: lstFactoresRiesgo ?? this.lstFactoresRiesgo,
        lstTiposSanitario: lstTiposSanitario ?? this.lstTiposSanitario,
        lstTiposCombustible: lstTiposCombustible ?? this.lstTiposCombustible,
        lstPresenciaAnimales: lstPresenciaAnimales ?? this.lstPresenciaAnimales,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "Familia_id": familiaId,
        "TipoVivienda_id": tipoViviendaId,
        "TenenciaVivienda_id": tenenciaViviendaId,
        "VentilacionVivienda_id": ventilacionViviendaId,
        /*  "IluminacionVivienda_id": iluminacionViviendaId, */
        "PisoVivienda_id": pisoViviendaId,
        "OtroTipoPiso": otroTipoPiso,
        "remoteVivienda_id": remoteViviendaId,
      };
}
