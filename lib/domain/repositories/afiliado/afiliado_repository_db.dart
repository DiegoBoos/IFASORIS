import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/afiliado_entity.dart';

abstract class AfiliadoRepositoryDB {
  Future<Either<Failure, List<AfiliadoEntity>>> getAfiliadosRepositoryDB(
      String query);

  Future<Either<Failure, int>> afiliadoTieneFichaRepositoryDB(int afiliadoId);
}
