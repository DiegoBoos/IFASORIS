import 'package:equatable/equatable.dart';

class EsquemaVacunacionEntity extends Equatable {
  final int? esquemaVacunacionId;
  final String? descripcion;

  const EsquemaVacunacionEntity({
    this.esquemaVacunacionId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        esquemaVacunacionId,
        descripcion,
      ];
}
