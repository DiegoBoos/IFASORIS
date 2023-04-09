import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_by_dpto_entity.dart';

abstract class EspecialidadMedTradicionalByDptoRepository {
  Future<Either<Failure, List<EspecialidadMedTradicionalByDptoEntity>>>
      getEspecialidadesMedTradicionalByDptoRepository(int dtoId);
}
