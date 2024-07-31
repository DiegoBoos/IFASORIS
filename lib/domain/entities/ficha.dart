import 'package:equatable/equatable.dart';

import '../../data/models/familia.dart';

class FichaEntity extends Equatable {
  final int? fichaId;
  final DateTime? fechaCreacion;
  final String? numFicha;
  final String? userNameCreacion;
  final String? userNameActualizacion;
  final DateTime? ultimaActualizacion;
  final FamiliaModel? familia;
  final int? fichaIdRemote;

  const FichaEntity({
    this.fichaId,
    this.fechaCreacion,
    this.numFicha,
    this.userNameCreacion,
    this.userNameActualizacion,
    this.ultimaActualizacion,
    this.familia,
    this.fichaIdRemote,
  });

  @override
  List<Object?> get props => [
        fichaId,
        fechaCreacion,
        numFicha,
        userNameCreacion,
        userNameActualizacion,
        ultimaActualizacion,
        familia,
        fichaIdRemote,
      ];
}
