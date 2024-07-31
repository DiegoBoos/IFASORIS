import 'package:equatable/equatable.dart';

class DificultadAccesoMedTradicionalEntity extends Equatable {
  final int? dificultadAccesoMedTradId;
  final String? descripcion;
  final int? departamentoIde;

  const DificultadAccesoMedTradicionalEntity({
    this.dificultadAccesoMedTradId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        dificultadAccesoMedTradId,
        descripcion,
        departamentoIde,
      ];
}
