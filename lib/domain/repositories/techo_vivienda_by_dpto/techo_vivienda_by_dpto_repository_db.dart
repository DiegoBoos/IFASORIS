import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda_entity.dart';

abstract class TechoViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTechoViviendaByDptoRepositoryDB(
      TechoViviendaEntity techoVivienda);

  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaByDptoRepositoryDB();
}
