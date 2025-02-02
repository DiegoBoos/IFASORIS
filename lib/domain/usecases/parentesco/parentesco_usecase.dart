import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/parentesco.dart';
import '../../repositories/parentesco/parentesco_repository.dart';

class ParentescoUsecase {
  final ParentescoRepository repository;

  ParentescoUsecase(this.repository);

  Future<Either<Failure, List<ParentescoEntity>>> getParentescosUsecase() {
    return repository.getParentescosRepository();
  }
}
