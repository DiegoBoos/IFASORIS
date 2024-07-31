import 'package:equatable/equatable.dart';

class CigarrilloDiaEntity extends Equatable {
  final int? numeroCigarrilloDiaId;
  final String? descripcion;

  const CigarrilloDiaEntity({
    this.numeroCigarrilloDiaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        numeroCigarrilloDiaId,
        descripcion,
      ];
}
