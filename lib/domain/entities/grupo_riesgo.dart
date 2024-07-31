import 'package:equatable/equatable.dart';

class GrupoRiesgoEntity extends Equatable {
  final int? grupoRiesgoId;
  final String? descripcion;

  const GrupoRiesgoEntity({
    this.grupoRiesgoId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        grupoRiesgoId,
        descripcion,
      ];
}
