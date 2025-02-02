import 'package:equatable/equatable.dart';

class PisoViviendaEntity extends Equatable {
  final int? pisoViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const PisoViviendaEntity({
    this.pisoViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        pisoViviendaId,
        descripcion,
        departamentoIde,
      ];
}
