import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/cereal.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal.dart';

abstract class CerealRepositoryDB {
  Future<Either<Failure, int>> saveCerealRepositoryDB(CerealEntity cereal);

  Future<Either<Failure, List<CerealEntity>>> getCerealesRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionCerealesRepositoryDB(
      int ubicacionId, List<LstCereal> lstCereales);

  Future<Either<Failure, List<LstCereal>>> getUbicacionCerealesRepositoryDB(
      int? ubicacionId);
}
