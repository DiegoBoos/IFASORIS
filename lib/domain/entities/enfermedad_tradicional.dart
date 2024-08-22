import 'package:equatable/equatable.dart';

class EnfermedadTradicionalEntity extends Equatable {
  final int? enfermedadTradicionalId;
  final String? descripcion;
  final int? departamentoId;

  const EnfermedadTradicionalEntity({
    this.enfermedadTradicionalId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        enfermedadTradicionalId,
        descripcion,
        departamentoId,
      ];
}
