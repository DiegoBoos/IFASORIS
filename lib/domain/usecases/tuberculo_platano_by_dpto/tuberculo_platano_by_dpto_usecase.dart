import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tuberculo_platano_entity.dart';
import '../../repositories/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_repository.dart';

class TuberculoPlatanoByDptoUsecase {
  final TuberculoPlatanoByDptoRepository repository;

  TuberculoPlatanoByDptoUsecase(this.repository);

  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosByDptoUsecase(int dtoId) {
    return repository.getTuberculosPlatanosByDptoRepository(dtoId);
  }
}
