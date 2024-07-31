import 'package:equatable/equatable.dart';

class EnfermedadTradicionalEntity extends Equatable {
  final int? enfermedadTradicionalId;
  final String? descripcion;

  const EnfermedadTradicionalEntity({
    this.enfermedadTradicionalId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        enfermedadTradicionalId,
        descripcion,
      ];
}
