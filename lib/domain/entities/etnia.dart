import 'package:equatable/equatable.dart';

class EtniaEntity extends Equatable {
  final int? etniaId;
  final String? descripcion;

  const EtniaEntity({
    this.etniaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        etniaId,
        descripcion,
      ];
}
