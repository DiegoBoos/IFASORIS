import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tuberculo_platano_entity.dart';

abstract class TuberculoPlatanoByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTuberculoPlatanoByDptoRepositoryDB(
      TuberculoPlatanoEntity tuberculoPlatano);

  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosByDptoRepositoryDB();
}
