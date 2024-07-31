import 'package:equatable/equatable.dart';

class MedioUtilizaMedTradicionalEntity extends Equatable {
  final int? medioUtilizaMedTradId;
  final String? descripcion;
  final int? departamentoIde;

  const MedioUtilizaMedTradicionalEntity({
    this.medioUtilizaMedTradId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        medioUtilizaMedTradId,
        descripcion,
        departamentoIde,
      ];
}
