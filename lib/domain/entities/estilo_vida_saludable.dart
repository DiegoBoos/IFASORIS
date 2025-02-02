import 'package:equatable/equatable.dart';

import '../../ui/blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart';

class EstiloVidaSaludableEntity extends Equatable {
  final int? estilosVidaId;
  final int? afiliadoId;
  final int? familiaId;
  final int? actividadFisicaId;
  final int? alimentacionId;
  final int? consumeCigarrillo;
  final int? consumoAlcoholId;
  final int? numeroCigarrilloDiaId;
  final int? consumoSustanciasPsicoactivas;
  final EstiloVidaSaludableState formStatus;

  const EstiloVidaSaludableEntity({
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

  @override
  List<Object?> get props => [
        estilosVidaId,
        afiliadoId,
        familiaId,
        actividadFisicaId,
        alimentacionId,
        consumoAlcoholId,
        consumeCigarrillo,
        numeroCigarrilloDiaId,
        consumoSustanciasPsicoactivas,
        formStatus,
      ];
}
