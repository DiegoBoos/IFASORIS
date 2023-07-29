import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuidado_salud_cond_riesgo_entity.dart';

abstract class CuidadoSaludCondRiesgoRepository {
  Future<Either<Failure, CuidadoSaludCondRiesgoEntity>>
      uploadCuidadoSaludCondRiesgoRepository();
}
