import 'package:equatable/equatable.dart';

class TipoCombustibleViviendaEntity extends Equatable {
  final int? tipoCombustibleViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const TipoCombustibleViviendaEntity({
    this.tipoCombustibleViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        tipoCombustibleViviendaId,
        descripcion,
        departamentoIde,
      ];
}
