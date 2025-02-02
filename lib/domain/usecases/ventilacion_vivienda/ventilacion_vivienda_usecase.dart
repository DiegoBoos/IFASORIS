import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ventilacion_vivienda.dart';
import '../../repositories/ventilacion_vivienda/ventilacion_vivienda_repository.dart';

class VentilacionViviendaUsecase {
  final VentilacionViviendaRepository repository;

  VentilacionViviendaUsecase(this.repository);

  Future<Either<Failure, List<VentilacionViviendaEntity>>>
      getVentilacionesViviendaUsecase() {
    return repository.getVentilacionesViviendaRepository();
  }
}
