import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/techo_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda_entity.dart';

abstract class TechoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveTechoViviendaRepositoryDB(
      TechoViviendaEntity techoVivienda);

  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaRepositoryDB();

  Future<Either<Failure, int>> saveTechosViviendaRepositoryDB(
      int datoViviendaId, List<LstTecho> lstTechos);

  Future<Either<Failure, List<LstTecho>>> getTechosViviendaViviendaRepositoryDB(
      int? datoViviendaId);
}
