import 'package:equatable/equatable.dart';

class CostoDesplazamientoEntity extends Equatable {
  final int? costoDesplazamientoId;
  final String? descripcion;

  const CostoDesplazamientoEntity({
    this.costoDesplazamientoId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        costoDesplazamientoId,
        descripcion,
      ];
}
