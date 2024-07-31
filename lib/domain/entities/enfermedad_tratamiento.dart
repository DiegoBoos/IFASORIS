import 'package:equatable/equatable.dart';

class EnfermedadTratamientoEntity extends Equatable {
  final int? enfermedadTratamientoId;
  final String? descripcion;

  const EnfermedadTratamientoEntity({
    this.enfermedadTratamientoId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        enfermedadTratamientoId,
        descripcion,
      ];
}
