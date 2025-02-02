import 'package:equatable/equatable.dart';

class MedioComunicacionEntity extends Equatable {
  final int? medioComunicacionId;
  final String? descripcion;

  const MedioComunicacionEntity({
    this.medioComunicacionId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        medioComunicacionId,
        descripcion,
      ];
}
