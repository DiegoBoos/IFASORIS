import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cigarrillo_dia_entity.dart';

abstract class CigarrilloDiaRepository {
  Future<Either<Failure, List<CigarrilloDiaEntity>>>
      getCigarrillosDiaRepository();
}
