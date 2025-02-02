import 'package:equatable/equatable.dart';

class TenenciaViviendaEntity extends Equatable {
  final int? tenenciaViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const TenenciaViviendaEntity({
    this.tenenciaViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        tenenciaViviendaId,
        descripcion,
        departamentoIde,
      ];
}
