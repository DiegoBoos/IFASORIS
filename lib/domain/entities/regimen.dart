import 'package:equatable/equatable.dart';

class RegimenEntity extends Equatable {
  final int? tipoRegimenId;
  final String? tipo;
  final String? descripcion;

  const RegimenEntity({
    this.tipoRegimenId,
    this.tipo,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        tipoRegimenId,
        tipo,
        descripcion,
      ];
}
