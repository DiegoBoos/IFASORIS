import 'dart:convert';

import '../../ui/blocs/dim_vivienda/dim_vivienda_bloc.dart';

class DimViviendaEntity {
  int? datoViviendaId;
  int? familiaId;
  int? tipoViviendaId;
  int? tenenciaViviendaId;
  List<int>? pisosViviendaIds;
  String? otroTipoPiso;
  List<int>? techosViviendaIds;
  String? otroTipoTecho;
  int? ventilacionViviendaId;
  int? iluminacionViviendaId;
  List<int>? serviciosPublicosViviendaIds;
  List<int>? tratamientosAguaViviendaIds;
  List<int>? tiposSanitarioViviendaIds;
  String? otroTipoSanitario;
  List<int>? tiposCombustibleViviendaIds;
  String? otroTipoCombustible;
  List<int>? factoresRiesgoViviendaIds;
  List<int>? presenciaAnimalesViviendaIds;
  String? otroPresenciaAnimal;
  DimViviendaState formStatus;

  DimViviendaEntity(
      {this.datoViviendaId,
      this.familiaId,
      this.tipoViviendaId,
      this.tenenciaViviendaId,
      this.pisosViviendaIds,
      this.otroTipoPiso,
      this.techosViviendaIds,
      this.otroTipoTecho,
      this.ventilacionViviendaId,
      this.iluminacionViviendaId,
      this.serviciosPublicosViviendaIds,
      this.tratamientosAguaViviendaIds,
      this.tiposSanitarioViviendaIds,
      this.otroTipoSanitario,
      this.tiposCombustibleViviendaIds,
      this.otroTipoCombustible,
      this.factoresRiesgoViviendaIds,
      this.presenciaAnimalesViviendaIds,
      this.otroPresenciaAnimal,
      this.formStatus = const DimViviendaFormInitial()});

  DimViviendaEntity copyWith(
          {int? datoViviendaId,
          int? familiaId,
          int? tipoViviendaId,
          int? tenenciaViviendaId,
          List<int>? pisosViviendaIds,
          String? otroTipoPiso,
          List<int>? techosViviendaIds,
          String? otroTipoTecho,
          int? ventilacionViviendaId,
          int? iluminacionViviendaId,
          List<int>? serviciosPublicosViviendaIds,
          List<int>? tratamientosAguaViviendaIds,
          List<int>? tiposSanitarioViviendaIds,
          String? otroTipoSanitario,
          List<int>? tiposCombustibleViviendaIds,
          String? otroTipoCombustible,
          List<int>? factoresRiesgoViviendaIds,
          List<int>? presenciaAnimalesViviendaIds,
          String? otroPresenciaAnimal,
          DimViviendaState? formStatus}) =>
      DimViviendaEntity(
        datoViviendaId: datoViviendaId ?? this.datoViviendaId,
        familiaId: familiaId ?? this.familiaId,
        tipoViviendaId: tipoViviendaId ?? this.tipoViviendaId,
        tenenciaViviendaId: tenenciaViviendaId ?? this.tenenciaViviendaId,
        pisosViviendaIds: pisosViviendaIds ?? this.pisosViviendaIds,
        otroTipoPiso: otroTipoPiso ?? this.otroTipoPiso,
        techosViviendaIds: techosViviendaIds ?? this.techosViviendaIds,
        otroTipoTecho: otroTipoTecho ?? this.otroTipoTecho,
        ventilacionViviendaId:
            ventilacionViviendaId ?? this.ventilacionViviendaId,
        iluminacionViviendaId:
            iluminacionViviendaId ?? this.iluminacionViviendaId,
        serviciosPublicosViviendaIds:
            serviciosPublicosViviendaIds ?? this.serviciosPublicosViviendaIds,
        tratamientosAguaViviendaIds:
            tratamientosAguaViviendaIds ?? this.tratamientosAguaViviendaIds,
        tiposSanitarioViviendaIds:
            tiposSanitarioViviendaIds ?? this.tiposSanitarioViviendaIds,
        otroTipoSanitario: otroTipoSanitario ?? this.otroTipoSanitario,
        tiposCombustibleViviendaIds:
            tiposCombustibleViviendaIds ?? this.tiposCombustibleViviendaIds,
        otroTipoCombustible: otroTipoCombustible ?? this.otroTipoCombustible,
        factoresRiesgoViviendaIds:
            factoresRiesgoViviendaIds ?? this.factoresRiesgoViviendaIds,
        presenciaAnimalesViviendaIds:
            presenciaAnimalesViviendaIds ?? this.presenciaAnimalesViviendaIds,
        otroPresenciaAnimal: otroPresenciaAnimal ?? this.otroPresenciaAnimal,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "Familia_id": familiaId,
        "TipoVivienda_id": tipoViviendaId,
        "TenenciaVivienda_id": tenenciaViviendaId,
        "PisosVivienda_ids": jsonEncode(pisosViviendaIds),
        "OtroTipoPiso": otroTipoPiso,
        "TechosVivienda_ids": jsonEncode(techosViviendaIds),
        "OtroTipoTecho": otroTipoTecho,
        "VentilacionVivienda_id": ventilacionViviendaId,
        "IluminacionVivienda_id": iluminacionViviendaId,
        "ServiciosPublicosVivienda_ids":
            jsonEncode(serviciosPublicosViviendaIds),
        "TratamientosAguaVivienda_ids": jsonEncode(tratamientosAguaViviendaIds),
        "TiposSanitarioVivienda_ids": jsonEncode(tiposSanitarioViviendaIds),
        "OtroTipoSanitario": otroTipoSanitario,
        "TiposCombustibleVivienda_ids": jsonEncode(tiposCombustibleViviendaIds),
        "OtroTipoCombustible": otroTipoCombustible,
        "FactoresRiesgoVivienda_ids": jsonEncode(factoresRiesgoViviendaIds),
        "PresenciaAnimalesVivienda_ids":
            jsonEncode(presenciaAnimalesViviendaIds),
        "OtroPresenciaAnimal": otroPresenciaAnimal,
      };
}
