import 'package:equatable/equatable.dart';

class EstadisticaEntity extends Equatable {
  final String? estadistica;
  final int? cantidad;

  const EstadisticaEntity({
    this.estadistica,
    this.cantidad,
  });

  @override
  List<Object?> get props => [
        estadistica,
        cantidad,
      ];
}
