import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_vacunacion.dart';

abstract class LugarVacunacionRepositoryDB {
  Future<Either<Failure, int>> saveLugarVacunacionRepositoryDB(
      LugarVacunacionEntity lugarVacunacion);

  Future<Either<Failure, List<LugarVacunacionEntity>>>
      getLugaresVacunacionRepositoryDB();
}
