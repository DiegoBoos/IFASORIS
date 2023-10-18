import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/ficha_entity.dart';

import '../../../core/error/failure.dart';

abstract class FichaRepositoryDB {
  Future<Either<Failure, FichaEntity>> createFichaRepositoryDB(
      FichaEntity ficha);
  Future<Either<Failure, int>> createFichaCompletaRepositoryDB(
      FichaEntity ficha);
  Future<Either<Failure, List<FichaEntity>>> loadFichasRepositoryDB(
      int familiaId);

  Future<Either<Failure, int>> deleteFichaRepositoryDB(int fichaId);

  Future<Either<Failure, List<FichaEntity>>>
      loadFichasDiligenciadasRepositoryDB(int familiaId);
}
