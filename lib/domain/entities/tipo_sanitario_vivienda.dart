import 'package:equatable/equatable.dart';

class TipoSanitarioViviendaEntity extends Equatable {
  final int? tipoSanitarioViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const TipoSanitarioViviendaEntity({
    this.tipoSanitarioViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        tipoSanitarioViviendaId,
        descripcion,
        departamentoIde,
      ];
}
