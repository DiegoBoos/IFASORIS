import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ultima_vez_inst_salud_entity.dart';
import '../../repositories/ultima_vez_inst_salud/ultima_vez_inst_salud_repository.dart';

class UltimaVezInstSaludUsecase {
  final UltimaVezInstSaludRepository repository;

  UltimaVezInstSaludUsecase(this.repository);

  Future<Either<Failure, List<UltimaVezInstSaludEntity>>>
      getUltimasVecesInstSaludUsecase() {
    return repository.getUltimasVecesInstSaludRepository();
  }
}
