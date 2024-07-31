import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/enfermedad_tradicional.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_tradicional.dart';
import '../../repositories/enfermedad_tradicional/enfermedad_tradicional_repository_db.dart';

class EnfermedadTradicionalUsecaseDB {
  final EnfermedadTradicionalRepositoryDB repositoryDB;

  EnfermedadTradicionalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEnfermedadTradicionalUsecaseDB(
      EnfermedadTradicionalEntity enfermedadTradicional) {
    return repositoryDB
        .saveEnfermedadTradicionalRepositoryDB(enfermedadTradicional);
  }

  Future<Either<Failure, List<EnfermedadTradicionalEntity>>>
      getEnfermedadesTradicionalesUsecaseDB() {
    return repositoryDB.getEnfermedadesTradicionalesRepositoryDB();
  }

  Future<Either<Failure, List<LstEnfermedadTradicional>>>
      getEnfermedadesTradicionalesAtencionSaludUsecaseDB(int? atencionSaludId) {
    return repositoryDB
        .getEnfermedadesTradicionalesAtencionSaludRepositoryDB(atencionSaludId);
  }

  Future<Either<Failure, int>>
      saveEnfermedadesTradicionalesAtencionSaludUsecaseDB(int atencionSalud,
          List<LstEnfermedadTradicional> lstEnfermedadTradicional) {
    return repositoryDB.saveEnfermedadesTradicionalesAtencionSaludRepositoryDB(
        atencionSalud, lstEnfermedadTradicional);
  }
}
