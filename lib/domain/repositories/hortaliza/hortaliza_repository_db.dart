import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/hortaliza.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza.dart';

abstract class HortalizaRepositoryDB {
  Future<Either<Failure, int>> saveHortalizaRepositoryDB(
      HortalizaEntity hortaliza);

  Future<Either<Failure, List<HortalizaEntity>>> getHortalizasRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionHortalizasRepositoryDB(
      int ubicacionId, List<LstHortaliza> lstHortalizas);

  Future<Either<Failure, List<LstHortaliza>>>
      getUbicacionHortalizasRepositoryDB(int? ubicacionId);
}
