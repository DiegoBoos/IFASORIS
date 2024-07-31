import 'package:equatable/equatable.dart';

class SeguimientoEnfermedadEntity extends Equatable {
  final int? seguimientoEnfermedadId;
  final String? descripcion;

  const SeguimientoEnfermedadEntity({
    this.seguimientoEnfermedadId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        seguimientoEnfermedadId,
        descripcion,
      ];
}
