import 'package:equatable/equatable.dart';

class DificultadAccesoCAEntity extends Equatable {
  final int? dificultaAccesoId;
  final String? descripcion;
  final int? departamentoIde;

  const DificultadAccesoCAEntity({
    this.dificultaAccesoId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        dificultaAccesoId,
        descripcion,
        departamentoIde,
      ];
}
