import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/techo_vivienda.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda.dart';

abstract class TechoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveTechoViviendaRepositoryDB(
      TechoViviendaEntity techoVivienda);

  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaRepositoryDB();

  Future<Either<Failure, int>> saveTechosViviendaRepositoryDB(
      int datoViviendaId, List<LstTecho> lstTecho);

  Future<Either<Failure, List<LstTecho>>> getTechosViviendaViviendaRepositoryDB(
      int? datoViviendaId);
}
