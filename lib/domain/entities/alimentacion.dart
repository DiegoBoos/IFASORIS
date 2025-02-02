import 'package:equatable/equatable.dart';

class AlimentacionEntity extends Equatable {
  final int? alimentacionId;
  final String? descripcion;

  const AlimentacionEntity({
    this.alimentacionId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        alimentacionId,
        descripcion,
      ];
}
