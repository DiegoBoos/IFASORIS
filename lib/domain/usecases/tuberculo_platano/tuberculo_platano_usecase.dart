import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tuberculo_platano.dart';
import '../../repositories/tuberculo_platano/tuberculo_platano_repository.dart';

class TuberculoPlatanoUsecase {
  final TuberculoPlatanoRepository repository;

  TuberculoPlatanoUsecase(this.repository);

  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosUsecase(int dtoId) {
    return repository.getTuberculosPlatanosRepository(dtoId);
  }
}
