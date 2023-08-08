import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/nombre_enfermedad_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_enfermedad_entity.dart';
import '../../repositories/nombre_enfermedad/nombre_enfermedad_repository_db.dart';

class NombreEnfermedadUsecaseDB {
  final NombreEnfermedadRepositoryDB repositoryDB;

  NombreEnfermedadUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveNombreEnfermedadUsecaseDB(
      NombreEnfermedadEntity nombreEnfermedad) {
    return repositoryDB.saveNombreEnfermedadRepositoryDB(nombreEnfermedad);
  }

  Future<Either<Failure, List<NombreEnfermedadEntity>>>
      getNombresEnfermedadesUsecaseDB() {
    return repositoryDB.getNombresEnfermedadesRepositoryDB();
  }

  Future<Either<Failure, List<LstNombreEnfermedad>>>
      getLstNombresEnfermedadesUsecaseDB(int? cuidadoSaludCondRiesgoId) {
    return repositoryDB
        .getLstNombresEnfermedadesRepositoryDB(cuidadoSaludCondRiesgoId);
  }

  Future<Either<Failure, int>> saveNombresEnfermedadesUsecaseDB(
      int cuidadoSaludCondRiesgoId,
      List<LstNombreEnfermedad> lstNombresEnfermedades) {
    return repositoryDB.saveNombresEnfermedadesRepositoryDB(
        cuidadoSaludCondRiesgoId, lstNombresEnfermedades);
  }
}
