import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/etnia.dart';

abstract class EtniaRepository {
  Future<Either<Failure, List<EtniaEntity>>> getEtniasRepository();
}
