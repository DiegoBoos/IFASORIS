import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional_model.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_entity.dart';

abstract class EspecialidadMedTradicionalByDptoRepositoryDB {
  Future<Either<Failure, int>> saveEspecialidadMedTradicionalByDptoRepositoryDB(
      EspecialidadMedTradicionalEntity especialidadMedTradicional);

  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalByDptoRepositoryDB();

  Future<Either<Failure, int>>
      saveUbicacionEspecialidadMedTradicionalRepositoryDB(
          int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional);

  Future<Either<Failure, int>> saveUbicacionNombresMedTradicionalRepositoryDB(
      int ubicacionId, List<LstNombreMedTradicional> lstNombreMedTradicional);

  Future<Either<Failure, List<LstEspMedTradicional>>>
      getUbicacionEspecialidadesMedTradicionalRepositoryDB(int? ubicacionId);

  Future<Either<Failure, List<LstNombreMedTradicional>>>
      getUbicacionNombresMedTradicionalRepositoryDB(int? ubicacionId);
}
