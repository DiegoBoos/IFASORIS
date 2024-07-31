import 'package:equatable/equatable.dart';

class OcupacionEntity extends Equatable {
  final int? ocupacionId;
  final String? descripcion;

  const OcupacionEntity({
    this.ocupacionId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        ocupacionId,
        descripcion,
      ];
}
