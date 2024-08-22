import 'package:equatable/equatable.dart';

class MedioComunicacionEntity extends Equatable {
  final int? medioComunicacionId;
  final String? descripcion;
  final int? departamentoId;

  const MedioComunicacionEntity({
    this.medioComunicacionId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        medioComunicacionId,
        descripcion,
        departamentoId,
      ];
}
