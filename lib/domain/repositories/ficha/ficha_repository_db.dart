import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estadistica_entity.dart';
import '../../entities/ficha_entity.dart';

abstract class FichaRepositoryDB {
  Future<Either<Failure, FichaEntity>> createFichaRepositoryDB(
      FichaEntity ficha);
  Future<Either<Failure, int>> createFichaCompletaRepositoryDB(
      FichaEntity ficha);
  Future<Either<Failure, List<FichaEntity>>> loadFichasRepositoryDB(
      int familiaId);

  Future<Either<Failure, int>> deleteFichaRepositoryDB(int fichaId);

  Future<Either<Failure, List<FichaEntity>>>
      loadFichasSincronizadasRepositoryDB();

  Future<Either<Failure, List<EstadisticaEntity>>>
      loadEstadisticasRepositoryDB();
}
