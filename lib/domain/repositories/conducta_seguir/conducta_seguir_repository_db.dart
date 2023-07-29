import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/conducta_seguir_entity.dart';

abstract class ConductaSeguirRepositoryDB {
  Future<Either<Failure, int>> saveConductaSeguirRepositoryDB(
      ConductaSeguirEntity conductaSeguir);

  Future<Either<Failure, List<ConductaSeguirEntity>>>
      getConductasSeguirRepositoryDB();
}
