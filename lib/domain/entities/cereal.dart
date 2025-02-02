import 'package:equatable/equatable.dart';

class CerealEntity extends Equatable {
  final int? cerealId;
  final String? descripcion;
  final int? departamentoIde;

  const CerealEntity({
    this.cerealId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        cerealId,
        descripcion,
        departamentoIde,
      ];
}
