import 'package:equatable/equatable.dart';

class TiempoTardaMedTradicionalEntity extends Equatable {
  final int? tiempoTardaMedTradId;
  final String? descripcion;

  const TiempoTardaMedTradicionalEntity({
    this.tiempoTardaMedTradId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        tiempoTardaMedTradId,
        descripcion,
      ];
}
