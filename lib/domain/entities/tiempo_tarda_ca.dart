import 'package:equatable/equatable.dart';

class TiempoTardaCAEntity extends Equatable {
  final int? tiempoTardaId;
  final String? descripcion;

  const TiempoTardaCAEntity({
    this.tiempoTardaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
