import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/afiliado_entity.dart';

abstract class AfiliadoRepositoryDB {
  Future<Either<Failure, int>> saveAfiliadoRepositoryDB(
      AfiliadoEntity afiliado);

  Future<Either<Failure, List<AfiliadoEntity>>> getAfiliadosRepositoryDB(
      String query);
}
