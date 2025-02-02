import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_solicitado.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_solicitado.dart';
import '../../repositories/servicio_solicitado/servicio_solicitado_repository_db.dart';

class ServicioSolicitadoUsecaseDB {
  final ServicioSolicitadoRepositoryDB repositoryDB;

  ServicioSolicitadoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveServicioSolicitadoUsecaseDB(
      ServicioSolicitadoEntity servicioSolicitado) {
    return repositoryDB.saveServicioSolicitadoRepositoryDB(servicioSolicitado);
  }

  Future<Either<Failure, List<ServicioSolicitadoEntity>>>
      getServiciosSolicitadosUsecaseDB() {
    return repositoryDB.getServiciosSolicitadosRepositoryDB();
  }

  Future<Either<Failure, List<LstServicioSolicitado>>>
      getLstServiciosSolicitadosUsecaseDB(int? cuidadoSaludCondRiesgoId) {
    return repositoryDB
        .getLstServiciosSolicitadosRepositoryDB(cuidadoSaludCondRiesgoId);
  }

  Future<Either<Failure, int>> saveServiciosSolicitadosUsecaseDB(
      int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados) {
    return repositoryDB.saveServiciosSolicitadosRepositoryDB(
        cuidadoSaludCondRiesgoId, lstServiciosSolicitados);
  }
}
