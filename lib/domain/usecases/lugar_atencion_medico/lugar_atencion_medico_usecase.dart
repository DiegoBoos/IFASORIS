import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_atencion_medico.dart';
import '../../repositories/lugar_atencion_medico/lugar_atencion_medico_repository.dart';

class LugarAtencionMedicoUsecase {
  final LugarAtencionMedicoRepository repository;

  LugarAtencionMedicoUsecase(this.repository);

  Future<Either<Failure, List<LugarAtencionMedicoEntity>>>
      getLugaresAtencionMedicoUsecase() {
    return repository.getLugaresAtencionMedicoRepository();
  }
}
