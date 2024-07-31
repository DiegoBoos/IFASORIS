import 'package:equatable/equatable.dart';

class EnfermedadAcudeEntity extends Equatable {
  final int? enfermedadAcudeId;
  final String? descripcion;

  const EnfermedadAcudeEntity({
    this.enfermedadAcudeId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        enfermedadAcudeId,
        descripcion,
      ];
}
