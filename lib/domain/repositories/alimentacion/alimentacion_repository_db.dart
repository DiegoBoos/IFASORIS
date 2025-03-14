import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/alimentacion_entity.dart';

abstract class AlimentacionRepositoryDB {
  Future<Either<Failure, int>> saveAlimentacionRepositoryDB(
      AlimentacionEntity alimentacion);

  Future<Either<Failure, List<AlimentacionEntity>>>
      getAlimentacionesRepositoryDB();
}
