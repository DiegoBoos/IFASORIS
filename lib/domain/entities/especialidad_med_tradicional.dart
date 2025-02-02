import 'package:equatable/equatable.dart';

class EspecialidadMedTradicionalEntity extends Equatable {
  final int? especialidadMedTradId;
  final String? descripcion;
  final int? departamentoIde;

  const EspecialidadMedTradicionalEntity({
    this.especialidadMedTradId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        especialidadMedTradId,
        descripcion,
        departamentoIde,
      ];
}
