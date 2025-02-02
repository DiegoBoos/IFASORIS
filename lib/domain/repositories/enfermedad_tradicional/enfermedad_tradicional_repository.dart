import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_tradicional.dart';

abstract class EnfermedadTradicionalRepository {
  Future<Either<Failure, List<EnfermedadTradicionalEntity>>>
      getEnfermedadesTradicionalesRepository(int dtoId);
}
