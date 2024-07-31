import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/conducta_seguir.dart';
import '../../repositories/conducta_seguir/conducta_seguir_repository.dart';

class ConductaSeguirUsecase {
  final ConductaSeguirRepository repository;

  ConductaSeguirUsecase(this.repository);

  Future<Either<Failure, List<ConductaSeguirEntity>>>
      getConductasSeguirUsecase() {
    return repository.getConductasSeguirRepository();
  }
}
