import 'package:equatable/equatable.dart';

class HortalizaEntity extends Equatable {
  final int? hortalizaId;
  final String? descripcion;
  final int? departamentoIde;

  const HortalizaEntity({
    this.hortalizaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        hortalizaId,
        descripcion,
        departamentoIde,
      ];
}
