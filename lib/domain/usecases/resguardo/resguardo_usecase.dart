import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo.dart';
import '../../repositories/resguardo/resguardo_repository.dart';

class ResguardoUsecase {
  final ResguardoRepository repository;

  ResguardoUsecase(this.repository);

  Future<Either<Failure, List<ResguardoEntity>>> getResguardosUsecase(
      int dtoId) {
    return repository.getResguardosRepository(dtoId);
  }
}
