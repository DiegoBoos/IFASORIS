import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_entity.dart';

abstract class EspecialidadMedTradicionalByDptoRepositoryDB {
  Future<Either<Failure, int>> saveEspecialidadMedTradicionalByDptoRepositoryDB(
      EspecialidadMedTradicionalEntity especialidadMedTradicional);

  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalByDptoRepositoryDB();
}
