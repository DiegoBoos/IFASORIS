import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ventilacion_vivienda.dart';
import '../../repositories/ventilacion_vivienda/ventilacion_vivienda_repository_db.dart';

class VentilacionViviendaUsecaseDB {
  final VentilacionViviendaRepositoryDB repositoryDB;

  VentilacionViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveVentilacionViviendaUsecaseDB(
      VentilacionViviendaEntity ventilacionVivienda) {
    return repositoryDB
        .saveVentilacionViviendaRepositoryDB(ventilacionVivienda);
  }

  Future<Either<Failure, List<VentilacionViviendaEntity>>>
      getVentilacionesViviendaUsecaseDB() {
    return repositoryDB.getVentilacionesViviendaRepositoryDB();
  }
}
