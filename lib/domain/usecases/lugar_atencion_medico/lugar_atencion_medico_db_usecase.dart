import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/lugar_atencion_medico.dart';
import '../../entities/lugar_atencion_medico.dart';
import '../../repositories/lugar_atencion_medico/lugar_atencion_medico_repository_db.dart';

class LugarAtencionMedicoUsecaseDB {
  final LugarAtencionMedicoRepositoryDB repositoryDB;

  LugarAtencionMedicoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveLugarAtencionMedicoUsecaseDB(
      LugarAtencionMedicoEntity lugarAtencionMedico) {
    return repositoryDB
        .saveLugarAtencionMedicoRepositoryDB(lugarAtencionMedico);
  }

  Future<Either<Failure, List<LugarAtencionMedicoEntity>>>
      getLugaresAtencionMedicoUsecaseDB() {
    return repositoryDB.getLugaresAtencionMedicoRepositoryDB();
  }

  Future<Either<Failure, List<LstLugarAtencionMedico>>>
      getLugaresAtencionMedicoAtencionSaludUsecaseDB(int? atencionSaludId) {
    return repositoryDB
        .getLugaresAtencionMedicoAtencionSaludRepositoryDB(atencionSaludId);
  }

  Future<Either<Failure, int>> saveLugaresAtencionMedicoAtencionSaludUsecaseDB(
      int atencionSalud, List<LstLugarAtencionMedico> lstLugarAtencionMedico) {
    return repositoryDB.saveLugaresAtencionMedicoAtencionSaludRepositoryDB(
        atencionSalud, lstLugarAtencionMedico);
  }
}
