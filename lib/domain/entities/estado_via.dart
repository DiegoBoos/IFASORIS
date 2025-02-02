import 'package:equatable/equatable.dart';

class EstadoViaEntity extends Equatable {
  final int? estadoViaId;
  final String? descripcion;

  const EstadoViaEntity({
    this.estadoViaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [estadoViaId, descripcion];
}
