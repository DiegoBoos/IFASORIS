import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_regimen.dart';

abstract class TipoRegimenRepositoryDB {
  Future<Either<Failure, int>> saveTipoRegimenRepositoryDB(
      TipoRegimenEntity tiporegimen);

  Future<Either<Failure, List<TipoRegimenEntity>>>
      getTipoRegimenesRepositoryDB();
}
