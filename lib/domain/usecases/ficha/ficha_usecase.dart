import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/ficha/ficha_repository.dart';

class FichaUsecase {
  final FichaRepository repository;

  FichaUsecase(this.repository);

  Future<Either<Failure, String>> createFichaUsecase() {
    return repository.createFichaRepository();
  }
}
