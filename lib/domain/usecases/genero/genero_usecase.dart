import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/genero.dart';
import '../../repositories/genero/genero_repository.dart';

class GeneroUsecase {
  final GeneroRepository repository;

  GeneroUsecase(this.repository);

  Future<Either<Failure, List<GeneroEntity>>> getGenerosUsecase() {
    return repository.getGenerosRepository();
  }
}
