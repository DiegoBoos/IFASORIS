import 'package:equatable/equatable.dart';

class MetodoPlanificacionEntity extends Equatable {
  final int? metodoPlanificacionId;
  final String? descripcion;

  const MetodoPlanificacionEntity({
    this.metodoPlanificacionId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        metodoPlanificacionId,
        descripcion,
      ];
}
