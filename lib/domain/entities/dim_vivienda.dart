import 'package:equatable/equatable.dart';

import '../../data/models/factor_riesgo_vivienda.dart';
import '../../data/models/piso_vivienda.dart';
import '../../data/models/presencia_animal_vivienda.dart';
import '../../data/models/servicio_publico_vivienda.dart';
import '../../data/models/techo_vivienda.dart';
import '../../data/models/tipo_combustible_vivienda.dart';
import '../../data/models/tipo_sanitario_vivienda.dart';
import '../../data/models/tratamiento_agua_vivienda.dart';
import '../../ui/blocs/dim_vivienda/dim_vivienda_bloc.dart';

class DimViviendaEntity extends Equatable {
  final int? datoViviendaId;
  final int? afiliadoId;
  final int? familiaId;
  final int? tipoViviendaId;
  final int? tenenciaViviendaId;
  final int? ventilacionViviendaId;
  final int? iluminacionViviendaId;
  final int? cuartosViviendaId;
  final List<LstPiso>? lstPiso;
  final List<LstTecho>? lstTecho;
  final List<LstServPublico>? lstServPublico;
  final List<LstTmtoAgua>? lstTmtoAgua;
  final List<LstFactorRiesgo>? lstFactorRiesgo;
  final List<LstTipoSanitario>? lstTipoSanitario;
  final List<LstTipoCombustible>? lstTipoCombustible;
  final List<LstPresenciaAnimal>? lstPresenciaAnimal;
  final DimViviendaState formStatus;

  const DimViviendaEntity({
    this.datoViviendaId,
    this.afiliadoId,
    this.familiaId,
    this.tipoViviendaId,
    this.tenenciaViviendaId,
    this.ventilacionViviendaId,
    this.iluminacionViviendaId,
    this.cuartosViviendaId,
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
          int? afiliadoId,
          int? familiaId,
          int? tipoViviendaId,
          int? tenenciaViviendaId,
          int? ventilacionViviendaId,
          int? iluminacionViviendaId,
          int? cuartosViviendaId,
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
        afiliadoId: afiliadoId ?? this.afiliadoId,
        familiaId: familiaId ?? this.familiaId,
        tipoViviendaId: tipoViviendaId ?? this.tipoViviendaId,
        tenenciaViviendaId: tenenciaViviendaId ?? this.tenenciaViviendaId,
        ventilacionViviendaId:
            ventilacionViviendaId ?? this.ventilacionViviendaId,
        iluminacionViviendaId:
            iluminacionViviendaId ?? this.iluminacionViviendaId,
        cuartosViviendaId: cuartosViviendaId ?? this.cuartosViviendaId,
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

  @override
  List<Object?> get props => [
        datoViviendaId,
        afiliadoId,
        familiaId,
        tipoViviendaId,
        tenenciaViviendaId,
        ventilacionViviendaId,
        iluminacionViviendaId,
        cuartosViviendaId,
        lstPiso,
        lstTecho,
        lstServPublico,
        lstTmtoAgua,
        lstFactorRiesgo,
        lstTipoSanitario,
        lstTipoCombustible,
        lstPresenciaAnimal,
        formStatus,
      ];
}
