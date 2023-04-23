import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/familia_entity.dart';
import '../../repositories/familia/familia_repository.dart';

class FamiliaUsecase {
  final FamiliaRepository repository;

  FamiliaUsecase(this.repository);

  Future<Either<Failure, FamiliaEntity>> createFamiliaUsecase(
      FamiliaEntity familia) {
    return repository.createFamiliaRepository(familia);
  }
}
