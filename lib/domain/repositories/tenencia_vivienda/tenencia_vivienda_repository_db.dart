import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tenencia_vivienda_entity.dart';

abstract class TenenciaViviendaRepositoryDB {
  Future<Either<Failure, int>> saveTenenciaViviendaRepositoryDB(
      TenenciaViviendaEntity tenenciaVivienda);

  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaRepositoryDB();
}
