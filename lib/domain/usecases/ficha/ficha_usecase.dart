import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ficha_entity.dart';
import '../../repositories/ficha/ficha_repository.dart';

class FichaUsecase {
  final FichaRepository repository;

  FichaUsecase(this.repository);

  Future<Either<Failure, FichaEntity>> createFichaUsecase(FichaEntity ficha) {
    return repository.createFichaRepository(ficha);
  }
}
