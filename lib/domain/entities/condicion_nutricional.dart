import 'package:equatable/equatable.dart';

class CondicionNutricionalEntity extends Equatable {
  final int? condicionNutricionalId;
  final String? descripcion;

  const CondicionNutricionalEntity({
    this.condicionNutricionalId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        condicionNutricionalId,
        descripcion,
      ];
}
