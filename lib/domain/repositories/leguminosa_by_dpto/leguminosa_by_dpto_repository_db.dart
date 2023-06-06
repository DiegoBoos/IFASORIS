import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/leguminosa_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa_entity.dart';

abstract class LeguminosaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveLeguminosaByDptoRepositoryDB(
      LeguminosaEntity leguminosa);

  Future<Either<Failure, List<LeguminosaEntity>>>
      getLeguminosasByDptoRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionLeguminosasRepositoryDB(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas);

  Future<Either<Failure, List<LstLeguminosa>>>
      getUbicacionLeguminosasRepositoryDB(int? ubicacionId);
}
