import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tuberculo_platano_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tuberculo_platano_entity.dart';

abstract class TuberculoPlatanoRepositoryDB {
  Future<Either<Failure, int>> saveTuberculoPlatanoRepositoryDB(
      TuberculoPlatanoEntity tuberculoPlatano);

  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionTuberculosPlatanosRepositoryDB(
      int ubicacionId, List<LstTuberculo> lstTuberculos);

  Future<Either<Failure, List<LstTuberculo>>>
      getUbicacionTuberculosPlatanosRepositoryDB(int? ubicacionId);
}
