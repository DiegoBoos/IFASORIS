import 'package:equatable/equatable.dart';

class EspecieAnimalEntity extends Equatable {
  final int? especieAnimalCriaId;
  final String? descripcion;
  final int? departamentoIde;

  const EspecieAnimalEntity({
    this.especieAnimalCriaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        especieAnimalCriaId,
        descripcion,
        departamentoIde,
      ];
}
