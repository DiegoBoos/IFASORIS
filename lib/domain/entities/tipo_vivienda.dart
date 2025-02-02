import 'package:equatable/equatable.dart';

class TipoViviendaEntity extends Equatable {
  final int? tipoViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const TipoViviendaEntity({
    this.tipoViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        tipoViviendaId,
        descripcion,
        departamentoIde,
      ];
}
