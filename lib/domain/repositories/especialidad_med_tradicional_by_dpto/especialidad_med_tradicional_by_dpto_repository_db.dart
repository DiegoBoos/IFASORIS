import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_by_dpto_entity.dart';

abstract class EspecialidadMedTradicionalByDptoRepositoryDB {
  Future<Either<Failure, int>> saveEspecialidadMedTradicionalByDptoRepositoryDB(
      EspecialidadMedTradicionalByDptoEntity especialidadMedTradicionalByDpto);

  Future<Either<Failure, List<EspecialidadMedTradicionalByDptoEntity>>>
      getEspecialidadesMedTradicionalByDptoRepositoryDB(int dtoId);
}
