import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/regimen.dart';

abstract class RegimenRepositoryDB {
  Future<Either<Failure, int>> saveRegimenRepositoryDB(RegimenEntity regimen);

  Future<Either<Failure, List<RegimenEntity>>> getRegimenesRepositoryDB();
}
