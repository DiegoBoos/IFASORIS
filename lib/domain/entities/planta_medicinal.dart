import 'package:equatable/equatable.dart';

class PlantaMedicinalEntity extends Equatable {
  final int? plantaMedicinalId;
  final String? descripcion;
  final int? departamentoId;

  const PlantaMedicinalEntity({
    this.plantaMedicinalId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        plantaMedicinalId,
        descripcion,
        departamentoId,
      ];
}
