import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/fruto.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto.dart';

abstract class FrutoRepositoryDB {
  Future<Either<Failure, int>> saveFrutoRepositoryDB(FrutoEntity fruto);

  Future<Either<Failure, List<FrutoEntity>>> getFrutosRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionFrutosRepositoryDB(
      int ubicacionId, List<LstFruto> lstFrutos);

  Future<Either<Failure, List<LstFruto>>> getUbicacionFrutosRepositoryDB(
      int? ubicacionId);
}
