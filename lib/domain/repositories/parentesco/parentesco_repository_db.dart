import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/parentesco_entity.dart';

abstract class ParentescoRepositoryDB {
  Future<Either<Failure, int>> saveParentescoRepositoryDB(
      ParentescoEntity parentesco);

  Future<Either<Failure, List<ParentescoEntity>>> getParentescosRepositoryDB();
}
