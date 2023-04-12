import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tuberculo_platano_entity.dart';

abstract class TuberculoPlatanoByDptoRepository {
  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosByDptoRepository(int dtoId);
}
