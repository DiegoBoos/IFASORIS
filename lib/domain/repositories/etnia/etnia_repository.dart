import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/etnia_entity.dart';

abstract class EtniaRepository {
  Future<Either<Failure, List<EtniaEntity>>> getEtniasRepository();
}
