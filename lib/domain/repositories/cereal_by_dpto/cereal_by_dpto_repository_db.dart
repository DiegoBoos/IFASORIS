import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal_entity.dart';

abstract class CerealByDptoRepositoryDB {
  Future<Either<Failure, int>> saveCerealByDptoRepositoryDB(
      CerealEntity cereal);

  Future<Either<Failure, List<CerealEntity>>> getCerealesByDptoRepositoryDB();
}
