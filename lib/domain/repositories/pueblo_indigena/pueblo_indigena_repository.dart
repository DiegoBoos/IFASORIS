import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/pueblo_indigena.dart';

abstract class PuebloIndigenaRepository {
  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasRepository(int dtoId);
}
