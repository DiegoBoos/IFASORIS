import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/atencion_salud_entity.dart';
import '../../repositories/atencion_salud/atencion_salud_repository_db.dart';

class AtencionSaludUsecaseDB {
  final AtencionSaludRepositoryDB repositoryDB;

  AtencionSaludUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveAtencionSaludUsecaseDB(
      AtencionSaludEntity atencionSalud) {
    return repositoryDB.saveAtencionSaludRepositoryDB(atencionSalud);
  }

  Future<Either<Failure, AtencionSaludEntity?>> getAtencionSaludUsecaseDB(
      int afiliadoId) {
    return repositoryDB.getAtencionSaludRepositoryDB(afiliadoId);
  }
}
