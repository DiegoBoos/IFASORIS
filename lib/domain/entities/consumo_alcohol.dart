import 'package:equatable/equatable.dart';

class ConsumoAlcoholEntity extends Equatable {
  final int? consumoAlcoholId;
  final String? descripcion;

  const ConsumoAlcoholEntity({
    this.consumoAlcoholId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        consumoAlcoholId,
        descripcion,
      ];
}
