import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura.dart';
import '../../repositories/verdura/verdura_repository.dart';

class VerduraUsecase {
  final VerduraRepository repository;

  VerduraUsecase(this.repository);

  Future<Either<Failure, List<VerduraEntity>>> getVerdurasUsecase(int dtoId) {
    return repository.getVerdurasRepository(dtoId);
  }
}
