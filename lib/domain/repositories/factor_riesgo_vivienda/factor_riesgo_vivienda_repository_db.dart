import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/factor_riesgo_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda_entity.dart';

abstract class FactorRiesgoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveFactorRiesgoViviendaRepositoryDB(
      FactorRiesgoViviendaEntity factorRiesgoVivienda);

  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoRepositoryDB();

  Future<Either<Failure, int>> saveFactoresRiesgoViviendaRepositoryDB(
      int datoViviendaId, List<LstFactoresRiesgo> lstFactoresRiesgo);

  Future<Either<Failure, List<LstFactoresRiesgo>>>
      getFactoresRiesgoViviendaRepositoryDB(int? datoViviendaId);
}
