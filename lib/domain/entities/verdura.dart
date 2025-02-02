import 'package:equatable/equatable.dart';

class VerduraEntity extends Equatable {
  final int? verduraId;
  final String? descripcion;
  final int? departamentoIde;

  const VerduraEntity({
    this.verduraId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        verduraId,
        descripcion,
        departamentoIde,
      ];
}
