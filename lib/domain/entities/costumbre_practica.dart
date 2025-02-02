import 'package:equatable/equatable.dart';

class CostumbrePracticaEntity extends Equatable {
  final int? costumbrePracticaId;
  final String? descripcion;

  const CostumbrePracticaEntity({
    this.costumbrePracticaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        costumbrePracticaId,
        descripcion,
      ];
}
