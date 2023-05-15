import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tenencia_vivienda_entity.dart';

abstract class TenenciaViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTenenciaViviendaByDptoRepositoryDB(
      TenenciaViviendaEntity tenenciaVivienda);

  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaByDptoRepositoryDB();
}
