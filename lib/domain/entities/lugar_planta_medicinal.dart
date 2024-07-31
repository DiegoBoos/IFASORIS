import 'package:equatable/equatable.dart';

class LugarPlantaMedicinalEntity extends Equatable {
  final int? lugarPlantaMedicinalId;
  final String? descripcion;

  const LugarPlantaMedicinalEntity({
    this.lugarPlantaMedicinalId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        lugarPlantaMedicinalId,
        descripcion,
      ];
}
