import 'package:equatable/equatable.dart';

class ViaAccesoEntity extends Equatable {
  final int? viaAccesoId;
  final String? descripcion;

  const ViaAccesoEntity({
    this.viaAccesoId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        viaAccesoId,
        descripcion,
      ];
}
