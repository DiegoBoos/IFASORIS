import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_comunicacion.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_comunicacion.dart';
import '../../repositories/medio_comunicacion/medio_comunicacion_repository_db.dart';

class MedioComunicacionUsecaseDB {
  final MedioComunicacionRepositoryDB repositoryDB;

  MedioComunicacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveMedioComunicacionUsecase(
      MedioComunicacionEntity medioComunicacion) {
    return repositoryDB.saveMedioComunicacionRepositoryDB(medioComunicacion);
  }

  Future<Either<Failure, List<MedioComunicacionEntity>>>
      getMediosComunicacionUsecase() {
    return repositoryDB.getMediosComunicacionRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionMediosComunicacionUsecaseDB(
      int ubicacionId, List<LstMediosComunica> lstMediosComunica) {
    return repositoryDB.saveUbicacionMediosComunicacionRepositoryDB(
        ubicacionId, lstMediosComunica);
  }

  Future<Either<Failure, List<LstMediosComunica>>>
      getUbicacionMediosComunicacionUsecaseDB(int? ubicacionId) {
    return repositoryDB.getUbicacionMediosComunicacionRepositoryDB(ubicacionId);
  }
}
