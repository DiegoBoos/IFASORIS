import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/etnia.dart';
import '../../repositories/etnia/etnia_repository.dart';

class EtniaUsecase {
  final EtniaRepository repository;

  EtniaUsecase(this.repository);

  Future<Either<Failure, List<EtniaEntity>>> getEtniasUsecase() {
    return repository.getEtniasRepository();
  }
}
