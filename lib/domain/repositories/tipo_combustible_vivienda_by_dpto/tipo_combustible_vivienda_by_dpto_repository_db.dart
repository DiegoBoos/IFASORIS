import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_combustible_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_combustible_vivienda_entity.dart';

abstract class TipoCombustibleViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTipoCombustibleViviendaByDptoRepositoryDB(
      TipoCombustibleViviendaEntity tipoCombustibleVivienda);

  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaByDptoRepositoryDB();

  Future<Either<Failure, int>> saveTiposCombustibleViviendaRepositoryDB(
      int datoViviendaId, List<LstTiposCombustible> lstTiposCombustible);

  Future<Either<Failure, List<LstTiposCombustible>>>
      getTiposCombustibleViviendaRepositoryDB(int? datoViviendaId);
}
