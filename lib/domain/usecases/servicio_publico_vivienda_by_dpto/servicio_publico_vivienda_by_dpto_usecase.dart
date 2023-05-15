import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_publico_vivienda_entity.dart';
import '../../repositories/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_repository.dart';

class ServicioPublicoViviendaByDptoUsecase {
  final ServicioPublicoViviendaByDptoRepository repository;

  ServicioPublicoViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaByDptoUsecase(int dtoId) {
    return repository.getServiciosPublicosViviendaByDptoRepository(dtoId);
  }
}
