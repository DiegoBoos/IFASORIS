import 'package:equatable/equatable.dart';

class NombreEnfermedadEntity extends Equatable {
  final int? nombreEnfermedadId;
  final String? descripcion;
  final int? departamentoId;

  const NombreEnfermedadEntity({
    this.nombreEnfermedadId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [nombreEnfermedadId, descripcion, departamentoId];
}
