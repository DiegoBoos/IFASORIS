import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/pueblo_indigena_entity.dart';

abstract class PuebloIndigenaByDptoRepository {
  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasByDptoRepository(int dtoId);
}
