import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/regimen_entity.dart';
import '../../repositories/regimen/regimen_repository.dart';

class RegimenUsecase {
  final RegimenRepository repository;

  RegimenUsecase(this.repository);

  Future<Either<Failure, List<RegimenEntity>>> getRegimenesUsecase() {
    return repository.getRegimenesRepository();
  }
}
