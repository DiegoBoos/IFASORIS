import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_publico_vivienda_entity.dart';

abstract class ServicioPublicoViviendaByDptoRepository {
  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaByDptoRepository(int dtoId);
}
