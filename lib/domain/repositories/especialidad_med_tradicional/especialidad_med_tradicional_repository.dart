import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_entity.dart';

abstract class EspecialidadMedTradicionalRepository {
  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalRepository(int dtoId);
}
