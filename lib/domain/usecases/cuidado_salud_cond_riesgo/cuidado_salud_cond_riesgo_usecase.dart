import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../repositories/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_repository.dart';

class CuidadoSaludCondRiesgoUsecase {
  final CuidadoSaludCondRiesgoRepository repository;

  CuidadoSaludCondRiesgoUsecase(this.repository);

  Future<Either<Failure, CuidadoSaludCondRiesgoEntity>>
      uploadCuidadoSaludCondRiesgoUsecase() {
    return repository.uploadCuidadoSaludCondRiesgoRepository();
  }
}
