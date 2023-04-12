import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto_entity.dart';

abstract class FrutoByDptoRepositoryDB {
  Future<Either<Failure, int>> saveFrutoByDptoRepositoryDB(FrutoEntity fruto);

  Future<Either<Failure, List<FrutoEntity>>> getFrutosByDptoRepositoryDB();
}
