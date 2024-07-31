import 'package:equatable/equatable.dart';

class FrutoEntity extends Equatable {
  final int? frutoId;
  final String? descripcion;
  final int? departamentoIde;

  const FrutoEntity({
    this.frutoId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        frutoId,
        descripcion,
        departamentoIde,
      ];
}
