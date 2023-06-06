import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/fruto_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto_entity.dart';

abstract class FrutoByDptoRepositoryDB {
  Future<Either<Failure, int>> saveFrutoByDptoRepositoryDB(FrutoEntity fruto);

  Future<Either<Failure, List<FrutoEntity>>> getFrutosByDptoRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionFrutosRepositoryDB(
      int ubicacionId, List<LstFruto> lstFrutos);

  Future<Either<Failure, List<LstFruto>>> getUbicacionFrutosRepositoryDB(
      int? ubicacionId);
}
