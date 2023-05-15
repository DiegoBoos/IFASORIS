import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_vivienda_entity.dart';

abstract class TipoViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTipoViviendaByDptoRepositoryDB(
      TipoViviendaEntity tipoVivienda);

  Future<Either<Failure, List<TipoViviendaEntity>>>
      getTiposViviendaByDptoRepositoryDB();
}
