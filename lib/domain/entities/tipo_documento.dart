import 'package:equatable/equatable.dart';

class TipoDocumentoEntity extends Equatable {
  final int? tipoDocumentoId;
  final String? tipo;
  final String? descripcion;

  const TipoDocumentoEntity({
    this.tipoDocumentoId,
    this.tipo,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        tipoDocumentoId,
        tipo,
        descripcion,
      ];
}
