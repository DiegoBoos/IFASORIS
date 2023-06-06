import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/cereal_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal_entity.dart';

abstract class CerealByDptoRepositoryDB {
  Future<Either<Failure, int>> saveCerealByDptoRepositoryDB(
      CerealEntity cereal);

  Future<Either<Failure, List<CerealEntity>>> getCerealesByDptoRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionCerealesRepositoryDB(
      int ubicacionId, List<LstCereal> lstCereales);

  Future<Either<Failure, List<LstCereal>>> getUbicacionCerealesRepositoryDB(
      int? ubicacionId);
}
