import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto_entity.dart';

abstract class FrutoByDptoRepository {
  Future<Either<Failure, List<FrutoEntity>>> getFrutosByDptoRepository(
      int dtoId);
}
