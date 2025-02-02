import 'package:equatable/equatable.dart';

class NombreLenguaMaternaEntity extends Equatable {
  final int? lenguaMaternaId;
  final String? descripcion;

  const NombreLenguaMaternaEntity({
    this.lenguaMaternaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        lenguaMaternaId,
        descripcion,
      ];
}
