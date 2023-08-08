import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/dificultad_acceso_med_tradicional_model.dart';
import '../../entities/dificultad_acceso_med_tradicional_entity.dart';

abstract class DificultadAccesoMedTradicionalRepositoryDB {
  Future<Either<Failure, int>> saveDificultadAccesoMedTradicionalRepositoryDB(
      DificultadAccesoMedTradicionalEntity dificultadAccesoMedTradicional);

  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionAccesoMedTradicionalRepositoryDB(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional);

  Future<Either<Failure, List<LstDificultadAccesoMedTradicional>>>
      getUbicacionDificultadesAccesoMedTradicionalRepositoryDB(
          int? ubicacionId);
}
