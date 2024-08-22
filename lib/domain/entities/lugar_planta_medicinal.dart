import 'package:equatable/equatable.dart';

class LugarPlantaMedicinalEntity extends Equatable {
  final int? lugarPlantaMedicinalId;
  final String? descripcion;
  final int? departamentoId;

  const LugarPlantaMedicinalEntity({
    this.lugarPlantaMedicinalId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        lugarPlantaMedicinalId,
        descripcion,
        departamentoId,
      ];
}
