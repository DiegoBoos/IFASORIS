import 'package:equatable/equatable.dart';

class OpcionSiNoEntity extends Equatable {
  final int? opcionId;
  final String? descripcion;

  const OpcionSiNoEntity({
    this.opcionId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        opcionId,
        descripcion,
      ];
}
