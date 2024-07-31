import 'package:equatable/equatable.dart';

class PresenciaAnimalViviendaEntity extends Equatable {
  final int? presenciaAnimalViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const PresenciaAnimalViviendaEntity({
    this.presenciaAnimalViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        presenciaAnimalViviendaId,
        descripcion,
        departamentoIde,
      ];
}
