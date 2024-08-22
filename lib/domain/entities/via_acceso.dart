import 'package:equatable/equatable.dart';

class ViaAccesoEntity extends Equatable {
  final int? viaAccesoId;
  final String? descripcion;
  final int? departamentoId;

  const ViaAccesoEntity({
    this.viaAccesoId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        viaAccesoId,
        descripcion,
        departamentoId,
      ];
}
