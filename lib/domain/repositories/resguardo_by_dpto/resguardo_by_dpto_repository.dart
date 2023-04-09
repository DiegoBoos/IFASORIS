import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo_by_dpto_entity.dart';

abstract class ResguardoByDptoRepository {
  Future<Either<Failure, List<ResguardoByDptoEntity>>>
      getResguardosByDptoRepository(int dtoId);
}
