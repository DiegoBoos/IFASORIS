import 'package:equatable/equatable.dart';

class TipoRegimenEntity extends Equatable {
  final int? regimenId;
  final String? codigo;
  final String? descripcion;

  const TipoRegimenEntity({
    this.regimenId,
    this.codigo,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        regimenId,
        codigo,
        descripcion,
      ];
}
