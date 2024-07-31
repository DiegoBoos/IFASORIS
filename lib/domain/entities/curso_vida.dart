import 'package:equatable/equatable.dart';

class CursoVidaEntity extends Equatable {
  final int? cursoVidaId;
  final String? descripcion;
  final String? rango;

  const CursoVidaEntity({
    this.cursoVidaId,
    this.descripcion,
    this.rango,
  });

  @override
  List<Object?> get props => [
        cursoVidaId,
        descripcion,
        rango,
      ];
}
