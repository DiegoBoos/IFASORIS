import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/familia_entity.dart';

import '../../../core/error/failure.dart';

abstract class FamiliaRepositoryDB {
  Future<Either<Failure, FamiliaEntity>> createFamiliaRepositoryDB(
      FamiliaEntity familia);

  Future<Either<Failure, List<FamiliaEntity>>> loadFamiliasRepositoryDB();

  Future<Either<Failure, int>> deleteAfiliadoFamiliaRepositoryDB(
      int? fkAfiliadoId);
}
