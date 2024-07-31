import 'package:equatable/equatable.dart';

class FactorRiesgoViviendaEntity extends Equatable {
  final int? factorRiesgoViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const FactorRiesgoViviendaEntity({
    this.factorRiesgoViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        factorRiesgoViviendaId,
        descripcion,
        departamentoIde,
      ];
}
