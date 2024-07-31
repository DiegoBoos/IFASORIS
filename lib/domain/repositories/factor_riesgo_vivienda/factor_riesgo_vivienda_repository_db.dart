import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/factor_riesgo_vivienda.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda.dart';

abstract class FactorRiesgoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveFactorRiesgoViviendaRepositoryDB(
      FactorRiesgoViviendaEntity factorRiesgoVivienda);

  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoRepositoryDB();

  Future<Either<Failure, int>> saveFactoresRiesgoViviendaRepositoryDB(
      int datoViviendaId, List<LstFactorRiesgo> lstFactorRiesgo);

  Future<Either<Failure, List<LstFactorRiesgo>>>
      getFactoresRiesgoViviendaRepositoryDB(int? datoViviendaId);
}
