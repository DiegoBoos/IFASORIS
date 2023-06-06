import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/hortaliza_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza_entity.dart';

abstract class HortalizaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveHortalizaByDptoRepositoryDB(
      HortalizaEntity hortaliza);

  Future<Either<Failure, List<HortalizaEntity>>>
      getHortalizasByDptoRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionHortalizasRepositoryDB(
      int ubicacionId, List<LstHortaliza> lstHortalizas);

  Future<Either<Failure, List<LstHortaliza>>>
      getUbicacionHortalizasRepositoryDB(int? ubicacionId);
}
