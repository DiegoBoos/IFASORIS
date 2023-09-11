import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_publico_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_publico_vivienda_entity.dart';
import '../../repositories/servicio_publico_vivienda/servicio_publico_vivienda_repository_db.dart';

class ServicioPublicoViviendaUsecaseDB {
  final ServicioPublicoViviendaRepositoryDB repositoryDB;

  ServicioPublicoViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveServicioPublicoViviendaUsecaseDB(
      ServicioPublicoViviendaEntity servicioPublicoVivienda) {
    return repositoryDB
        .saveServicioPublicoViviendaRepositoryDB(servicioPublicoVivienda);
  }

  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosUsecaseDB() {
    return repositoryDB.getServiciosPublicosRepositoryDB();
  }

  Future<Either<Failure, int>> saveServiciosPublicosViviendaUsecaseDB(
      int datoViviendaId, List<LstServPublico> lstServPublico) {
    return repositoryDB.saveServiciosPublicosViviendaRepositoryDB(
        datoViviendaId, lstServPublico);
  }

  Future<Either<Failure, List<LstServPublico>>> getServiciosPublicosViviendaDB(
      int? datoViviendaId) {
    return repositoryDB
        .getServiciosPublicosViviendaRepositoryDB(datoViviendaId);
  }
}
