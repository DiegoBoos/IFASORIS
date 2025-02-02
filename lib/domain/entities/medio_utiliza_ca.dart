import 'package:equatable/equatable.dart';

class MedioUtilizaCAEntity extends Equatable {
  final int? medioUtilizaId;
  final String? descripcion;
  final int? departamentoIde;

  const MedioUtilizaCAEntity({
    this.medioUtilizaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        medioUtilizaId,
        descripcion,
        departamentoIde,
      ];
}
