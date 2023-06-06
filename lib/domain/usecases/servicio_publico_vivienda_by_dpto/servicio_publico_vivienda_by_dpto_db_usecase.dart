import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_publico_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_publico_vivienda_entity.dart';
import '../../repositories/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_repository_db.dart';

class ServicioPublicoViviendaByDptoUsecaseDB {
  final ServicioPublicoViviendaByDptoRepositoryDB repositoryDB;

  ServicioPublicoViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveServicioPublicoViviendaByDptoUsecaseDB(
      ServicioPublicoViviendaEntity servicioPublicoVivienda) {
    return repositoryDB
        .saveServicioPublicoViviendaByDptoRepositoryDB(servicioPublicoVivienda);
  }

  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaByDptoUsecaseDB() {
    return repositoryDB.getServiciosPublicosViviendaByDptoRepositoryDB();
  }

  Future<Either<Failure, int>> saveServiciosPublicosViviendaUsecaseDB(
      int datoViviendaId, List<LstServPublico> lstServPublicos) {
    return repositoryDB.saveServiciosPublicosViviendaRepositoryDB(
        datoViviendaId, lstServPublicos);
  }

  Future<Either<Failure, List<LstServPublico>>> getServiciosPublicosViviendaDB(
      int? datoViviendaId) {
    return repositoryDB
        .getServiciosPublicosViviendaRepositoryDB(datoViviendaId);
  }
}
