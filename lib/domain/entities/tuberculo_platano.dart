import 'package:equatable/equatable.dart';

class TuberculoPlatanoEntity extends Equatable {
  final int? tuberculoPlatanoId;
  final String? descripcion;
  final int? departamentoIde;

  const TuberculoPlatanoEntity({
    this.tuberculoPlatanoId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        tuberculoPlatanoId,
        descripcion,
        departamentoIde,
      ];
}
