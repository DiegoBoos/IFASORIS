import 'package:equatable/equatable.dart';

class PuebloIndigenaEntity extends Equatable {
  final int? puebloIde;
  final int? departamentoIde;
  final String? descripcion;

  const PuebloIndigenaEntity({
    this.puebloIde,
    this.departamentoIde,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        puebloIde,
        departamentoIde,
        descripcion,
      ];
}
