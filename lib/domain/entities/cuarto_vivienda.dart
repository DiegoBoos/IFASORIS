import 'package:equatable/equatable.dart';

class CuartoViviendaEntity extends Equatable {
  final int? cuartoViviendaId;
  final String? descripcion;

  const CuartoViviendaEntity({
    this.cuartoViviendaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        cuartoViviendaId,
        descripcion,
      ];
}
