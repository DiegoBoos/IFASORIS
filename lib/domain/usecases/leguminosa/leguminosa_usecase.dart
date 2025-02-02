import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa.dart';
import '../../repositories/leguminosa/leguminosa_repository.dart';

class LeguminosaUsecase {
  final LeguminosaRepository repository;

  LeguminosaUsecase(this.repository);

  Future<Either<Failure, List<LeguminosaEntity>>> getLeguminosasUsecase(
      int dtoId) {
    return repository.getLeguminosasRepository(dtoId);
  }
}
