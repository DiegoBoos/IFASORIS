import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cigarrillo_dia.dart';
import '../../repositories/cigarrillo_dia/cigarrillo_dia_repository.dart';

class CigarrilloDiaUsecase {
  final CigarrilloDiaRepository repository;

  CigarrilloDiaUsecase(this.repository);

  Future<Either<Failure, List<CigarrilloDiaEntity>>>
      getCigarrillosDiaUsecase() {
    return repository.getCigarrillosDiaRepository();
  }
}
