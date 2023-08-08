import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_publico_vivienda_entity.dart';
import '../../repositories/servicio_publico_vivienda/servicio_publico_vivienda_repository.dart';

class ServicioPublicoViviendaUsecase {
  final ServicioPublicoViviendaRepository repository;

  ServicioPublicoViviendaUsecase(this.repository);

  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaUsecase(int dtoId) {
    return repository.getServiciosPublicosViviendaRepository(dtoId);
  }
}
