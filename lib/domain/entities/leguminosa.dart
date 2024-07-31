import 'package:equatable/equatable.dart';

class LeguminosaEntity extends Equatable {
  final int? leguminosaId;
  final String? descripcion;
  final int? departamentoIde;

  const LeguminosaEntity({
    this.leguminosaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        leguminosaId,
        descripcion,
        departamentoIde,
      ];
}
