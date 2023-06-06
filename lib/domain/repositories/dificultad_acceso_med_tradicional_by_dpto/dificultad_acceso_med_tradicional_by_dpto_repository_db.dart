import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/dificultad_acceso_med_tradicional_model.dart';
import '../../entities/dificultad_acceso_med_tradicional_entity.dart';

abstract class DificultadAccesoMedTradicionalByDptoRepositoryDB {
  Future<Either<Failure, int>>
      saveDificultadAccesoMedTradicionalByDptoRepositoryDB(
          DificultadAccesoMedTradicionalEntity dificultadAccesoMedTradicional);

  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalByDptoRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionAccesoMedTradicionalRepositoryDB(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional);

  Future<Either<Failure, List<LstDificultadAccesoMedTradicional>>>
      getUbicacionDificultadesAccesoMedTradicionalRepositoryDB(
          int? ubicacionId);
}
