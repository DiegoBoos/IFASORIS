import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_combustible_vivienda_entity.dart';

abstract class TipoCombustibleViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTipoCombustibleViviendaByDptoRepositoryDB(
      TipoCombustibleViviendaEntity tipoCombustibleVivienda);

  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaByDptoRepositoryDB();
}
