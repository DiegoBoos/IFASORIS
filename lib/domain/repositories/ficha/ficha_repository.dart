import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ficha_entity.dart';

abstract class FichaRepository {
  Future<Either<Failure, List<dynamic>>> createFichaRepository();
  Future<Either<Failure, List<FichaEntity>>> getFichasRepository(
      String userName);
}
