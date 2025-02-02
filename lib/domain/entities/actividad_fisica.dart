import 'package:equatable/equatable.dart';

class ActividadFisicaEntity extends Equatable {
  final int? actividadFisicaId;
  final String? descripcion;

  const ActividadFisicaEntity({
    this.actividadFisicaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        actividadFisicaId,
        descripcion,
      ];
}
