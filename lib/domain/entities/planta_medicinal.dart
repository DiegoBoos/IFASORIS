import 'package:equatable/equatable.dart';

class PlantaMedicinalEntity extends Equatable {
  final int? plantaMedicinalId;
  final String? descripcion;

  const PlantaMedicinalEntity({
    this.plantaMedicinalId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        plantaMedicinalId,
        descripcion,
      ];
}
