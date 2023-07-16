import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/actividad_fisica_entity.dart';

abstract class ActividadFisicaRepositoryDB {
  Future<Either<Failure, int>> saveActividadFisicaRepositoryDB(
      ActividadFisicaEntity actividadFisica);

  Future<Either<Failure, List<ActividadFisicaEntity>>>
      getActividadesFisicasRepositoryDB();
}
