import 'package:equatable/equatable.dart';

class SancionJusticiaEntity extends Equatable {
  final int? sancionJusticiaId;
  final String? descripcion;

  const SancionJusticiaEntity({
    this.sancionJusticiaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        sancionJusticiaId,
        descripcion,
      ];
}
