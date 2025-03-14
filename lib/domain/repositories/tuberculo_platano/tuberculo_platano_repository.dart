import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tuberculo_platano_entity.dart';

abstract class TuberculoPlatanoRepository {
  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosRepository(int dtoId);
}
