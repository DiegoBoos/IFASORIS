import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa_entity.dart';

abstract class LeguminosaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveLeguminosaByDptoRepositoryDB(
      LeguminosaEntity leguminosa);

  Future<Either<Failure, List<LeguminosaEntity>>>
      getLeguminosasByDptoRepositoryDB();
}
