import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/leguminosa.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa.dart';

abstract class LeguminosaRepositoryDB {
  Future<Either<Failure, int>> saveLeguminosaRepositoryDB(
      LeguminosaEntity leguminosa);

  Future<Either<Failure, List<LeguminosaEntity>>> getLeguminosasRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionLeguminosasRepositoryDB(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas);

  Future<Either<Failure, List<LstLeguminosa>>>
      getUbicacionLeguminosasRepositoryDB(int? ubicacionId);
}
