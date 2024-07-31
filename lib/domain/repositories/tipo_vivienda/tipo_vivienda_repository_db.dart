import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_vivienda.dart';

abstract class TipoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveTipoViviendaRepositoryDB(
      TipoViviendaEntity tipoVivienda);

  Future<Either<Failure, List<TipoViviendaEntity>>>
      getTiposViviendaRepositoryDB();
}
