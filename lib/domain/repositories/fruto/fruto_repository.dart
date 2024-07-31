import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto.dart';

abstract class FrutoRepository {
  Future<Either<Failure, List<FrutoEntity>>> getFrutosRepository(int dtoId);
}
