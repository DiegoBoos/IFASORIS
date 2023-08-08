import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_combustible_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_combustible_vivienda_entity.dart';

abstract class TipoCombustibleViviendaRepositoryDB {
  Future<Either<Failure, int>> saveTipoCombustibleViviendaRepositoryDB(
      TipoCombustibleViviendaEntity tipoCombustibleVivienda);

  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleRepositoryDB();

  Future<Either<Failure, int>> saveTiposCombustibleViviendaRepositoryDB(
      int datoViviendaId, List<LstTiposCombustible> lstTiposCombustible);

  Future<Either<Failure, List<LstTiposCombustible>>>
      getTiposCombustibleViviendaRepositoryDB(int? datoViviendaId);
}
