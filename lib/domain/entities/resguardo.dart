import 'package:equatable/equatable.dart';

class ResguardoEntity extends Equatable {
  final int? resguardoId;
  final String? nombreResguardo;
  final String? codaneResguardo;
  final int? departamentoIde;

  const ResguardoEntity({
    this.resguardoId,
    this.nombreResguardo,
    this.codaneResguardo,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        resguardoId,
        nombreResguardo,
        codaneResguardo,
        departamentoIde,
      ];
}
