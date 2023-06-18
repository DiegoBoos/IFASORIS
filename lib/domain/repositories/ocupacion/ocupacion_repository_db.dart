import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ocupacion_entity.dart';

abstract class OcupacionRepositoryDB {
  Future<Either<Failure, int>> saveOcupacionRepositoryDB(
      OcupacionEntity ocupacion);

  Future<Either<Failure, List<OcupacionEntity>>> getOcupacionesRepositoryDB();
}
