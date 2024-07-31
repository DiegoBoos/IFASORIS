import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional.dart';

abstract class EspecialidadMedTradicionalRepositoryDB {
  Future<Either<Failure, int>> saveEspecialidadMedTradicionalRepositoryDB(
      EspecialidadMedTradicionalEntity especialidadMedTradicional);

  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalRepositoryDB();

  Future<Either<Failure, int>>
      saveUbicacionEspecialidadMedTradicionalRepositoryDB(
          int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional);

  Future<Either<Failure, int>> saveUbicacionNombresMedTradicionalRepositoryDB(
      int ubicacionId, List<LstNombreMedTradicional> lstNombreMedTradicional);

  Future<Either<Failure, List<LstEspMedTradicional>>>
      getUbicacionEspecialidadesMedTradicionalRepositoryDB(int? ubicacionId);

  Future<Either<Failure, List<LstNombreMedTradicional>>>
      getUbicacionNombresMedTradicionalRepositoryDB(int? ubicacionId);

  Future<Either<Failure, List<LstEspMedTradicional>>>
      getEspecialidadesMedTradicionalAtencionSaludRepositoryDB(
          int? atencionSaludId);

  Future<Either<Failure, int>>
      saveEspecialidadesMedTradicionalAtencionSaludRepositoryDB(
          int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional);
}
