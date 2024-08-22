import 'dart:convert';

import '../../domain/entities/estilo_vida_saludable.dart';

List<EstiloVidaSaludableModel> listEstiloVidaSaludableFromJson(String str) =>
    List<EstiloVidaSaludableModel>.from(
        json.decode(str).map((x) => EstiloVidaSaludableModel.fromJson(x)));

EstiloVidaSaludableModel estiloVidaSaludableFromJson(String str) =>
    EstiloVidaSaludableModel.fromJson(json.decode(str));

class EstiloVidaSaludableModel extends EstiloVidaSaludableEntity {
  const EstiloVidaSaludableModel({
    int? estilosVidaId,
    int? afiliadoId,
    int? familiaId,
    int? actividadFisicaId,
    int? alimentacionId,
    int? consumoAlcoholId,
    int? consumeCigarrillo,
    int? numeroCigarrilloDiaId,
    int? consumoSustanciasPsicoactivas,
  }) : super(
          estilosVidaId: estilosVidaId,
          afiliadoId: afiliadoId,
          familiaId: familiaId,
          actividadFisicaId: actividadFisicaId,
          alimentacionId: alimentacionId,
          consumoAlcoholId: consumoAlcoholId,
          consumeCigarrillo: consumeCigarrillo,
          numeroCigarrilloDiaId: numeroCigarrilloDiaId,
          consumoSustanciasPsicoactivas: consumoSustanciasPsicoactivas,
        );

  static EstiloVidaSaludableModel fromEntity(EstiloVidaSaludableEntity entity) {
    return EstiloVidaSaludableModel(
      estilosVidaId: entity.estilosVidaId,
      afiliadoId: entity.afiliadoId,
      familiaId: entity.familiaId,
      actividadFisicaId: entity.actividadFisicaId,
      alimentacionId: entity.alimentacionId,
      consumoAlcoholId: entity.consumoAlcoholId,
      consumeCigarrillo: entity.consumeCigarrillo,
      numeroCigarrilloDiaId: entity.numeroCigarrilloDiaId,
      consumoSustanciasPsicoactivas: entity.consumoSustanciasPsicoactivas,
    );
  }

  factory EstiloVidaSaludableModel.fromJson(Map<String, dynamic> json) =>
      EstiloVidaSaludableModel(
        estilosVidaId: json["EstilosVida_id"],
        afiliadoId: json["Afiliado_id"],
        familiaId: json["Familia_id"],
        actividadFisicaId: json["ActividadFisica_id"],
        alimentacionId: json["Alimentacion_id"],
        consumoAlcoholId: json["ConsumoAlcohol_id"],
        consumeCigarrillo: json["ConsumeCigarrillo"],
        numeroCigarrilloDiaId: json["NumeroCigarrilloDia_id"],
        consumoSustanciasPsicoactivas: json["ConsumoSustanciasPsicoactivas"],
      );

  Map<String, dynamic> toJson() => {
        "EstilosVida_id": estilosVidaId,
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "ActividadFisica_id": actividadFisicaId,
        "Alimentacion_id": alimentacionId,
        "ConsumoAlcohol_id": consumoAlcoholId,
        "ConsumeCigarrillo": consumeCigarrillo,
        "NumeroCigarrilloDia_id": numeroCigarrilloDiaId,
        "ConsumoSustanciasPsicoactivas": consumoSustanciasPsicoactivas,
      };
}
