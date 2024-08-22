import 'package:equatable/equatable.dart';

class CostumbrePracticaEntity extends Equatable {
  final int? costumbrePracticaId;
  final String? descripcion;
  final int? departamentoId;

  const CostumbrePracticaEntity({
    this.costumbrePracticaId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        costumbrePracticaId,
        descripcion,
        departamentoId,
      ];
}
