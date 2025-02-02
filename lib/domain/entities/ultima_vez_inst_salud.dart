import 'package:equatable/equatable.dart';

class UltimaVezInstSaludEntity extends Equatable {
  final int? ultimaVezInstSaludId;
  final String? descripcion;

  const UltimaVezInstSaludEntity({
    this.ultimaVezInstSaludId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        ultimaVezInstSaludId,
        descripcion,
      ];
}
