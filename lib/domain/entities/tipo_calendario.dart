import 'package:equatable/equatable.dart';

class TipoCalendarioEntity extends Equatable {
  final int? tipoCalendarioId;
  final String? descripcion;

  const TipoCalendarioEntity({
    this.tipoCalendarioId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        tipoCalendarioId,
        descripcion,
      ];
}
