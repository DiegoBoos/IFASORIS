import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura_entity.dart';

abstract class VerduraByDptoRepositoryDB {
  Future<Either<Failure, int>> saveVerduraByDptoRepositoryDB(
      VerduraEntity verdura);

  Future<Either<Failure, List<VerduraEntity>>> getVerdurasByDptoRepositoryDB();
}
