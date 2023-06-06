import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/techo_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda_entity.dart';

abstract class TechoViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTechoViviendaByDptoRepositoryDB(
      TechoViviendaEntity techoVivienda);

  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaByDptoRepositoryDB();

  Future<Either<Failure, int>> saveTechosViviendaRepositoryDB(
      int datoViviendaId, List<LstTecho> lstTechos);

  Future<Either<Failure, List<LstTecho>>> getTechosViviendaRepositoryDB(
      int? datoViviendaId);
}
