import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/etnia_entity.dart';

abstract class EtniaRepositoryDB {
  Future<Either<Failure, int>> saveEtniaRepositoryDB(EtniaEntity etnia);

  Future<Either<Failure, List<EtniaEntity>>> getEtniasRepositoryDB();
}
