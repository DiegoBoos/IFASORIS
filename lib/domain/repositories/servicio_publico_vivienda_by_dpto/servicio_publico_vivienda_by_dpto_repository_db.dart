import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_publico_vivienda_entity.dart';

abstract class ServicioPublicoViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveServicioPublicoViviendaByDptoRepositoryDB(
      ServicioPublicoViviendaEntity servicioPublicoVivienda);

  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaByDptoRepositoryDB();
}
