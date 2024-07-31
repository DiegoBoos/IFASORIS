import 'package:equatable/equatable.dart';

class ServicioSolicitadoEntity extends Equatable {
  final int? servicioSolicitadoId;
  final String? descripcion;

  const ServicioSolicitadoEntity({
    this.servicioSolicitadoId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        servicioSolicitadoId,
        descripcion,
      ];
}
