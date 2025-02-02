import 'package:equatable/equatable.dart';

class NombreEnfermedadEntity extends Equatable {
  final int? nombreEnfermedadId;
  final String? descripcion;

  const NombreEnfermedadEntity({
    this.nombreEnfermedadId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        nombreEnfermedadId,
        descripcion,
      ];
}
