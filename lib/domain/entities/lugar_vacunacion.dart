import 'package:equatable/equatable.dart';

class LugarVacunacionEntity extends Equatable {
  final int? lugarVacunacionId;
  final String? descripcion;

  const LugarVacunacionEntity({
    this.lugarVacunacionId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        lugarVacunacionId,
        descripcion,
      ];
}
