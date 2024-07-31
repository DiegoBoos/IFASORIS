import 'package:equatable/equatable.dart';

class SyncLogEntity extends Equatable {
  final String? tabla;
  final int? cantidadRegistros;

  const SyncLogEntity({this.tabla, this.cantidadRegistros});

  @override
  List<Object?> get props => [
        tabla,
        cantidadRegistros,
      ];
}
