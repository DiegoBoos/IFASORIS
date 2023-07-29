import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/religion_profesa_entity.dart';
import '../../repositories/religion_profesa/religion_profesa_repository.dart';

class ReligionProfesaUsecase {
  final ReligionProfesaRepository repository;

  ReligionProfesaUsecase(this.repository);

  Future<Either<Failure, List<ReligionProfesaEntity>>>
      getReligionesProfesaUsecase() {
    return repository.getReligionesProfesaRepository();
  }
}
