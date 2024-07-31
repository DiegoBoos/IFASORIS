import 'package:equatable/equatable.dart';

class TechoViviendaEntity extends Equatable {
  final int? techoViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const TechoViviendaEntity({
    this.techoViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        techoViviendaId,
        descripcion,
        departamentoIde,
      ];
}
