import '../../ui/blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart';

class EstiloVidaSaludableEntity {
  EstiloVidaSaludableEntity({
    this.estilosVidaId,
    this.afiliadoId,
    this.familiaId,
    this.actividadFisicaId,
    this.alimentacionId,
    this.consumoAlcoholId,
    this.consumeCigarrillo,
    this.numeroCigarrilloDiaId,
    this.consumoSustanciasPsicoactivas,
    this.formStatus = const EstiloVidaSaludableFormInitial(),
  });

  int? estilosVidaId;
  int? afiliadoId;
  int? familiaId;
  int? actividadFisicaId;
  int? alimentacionId;
  int? consumeCigarrillo;
  int? consumoAlcoholId;
  int? numeroCigarrilloDiaId;
  int? consumoSustanciasPsicoactivas;
  EstiloVidaSaludableState formStatus;

  EstiloVidaSaludableEntity copyWith({
    int? estilosVidaId,
    int? afiliadoId,
    int? familiaId,
    int? actividadFisicaId,
    int? alimentacionId,
    int? consumoAlcoholId,
    int? consumeCigarrillo,
    int? numeroCigarrilloDiaId,
    int? consumoSustanciasPsicoactivas,
    EstiloVidaSaludableState? formStatus,
  }) =>
      EstiloVidaSaludableEntity(
        estilosVidaId: estilosVidaId ?? this.estilosVidaId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
        familiaId: familiaId ?? this.familiaId,
        actividadFisicaId: actividadFisicaId ?? this.actividadFisicaId,
        alimentacionId: alimentacionId ?? this.alimentacionId,
        consumoAlcoholId: consumoAlcoholId ?? this.consumoAlcoholId,
        consumeCigarrillo: consumeCigarrillo ?? this.consumeCigarrillo,
        numeroCigarrilloDiaId:
            numeroCigarrilloDiaId ?? this.numeroCigarrilloDiaId,
        consumoSustanciasPsicoactivas:
            consumoSustanciasPsicoactivas ?? this.consumoSustanciasPsicoactivas,
        formStatus: formStatus ?? this.formStatus,
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
