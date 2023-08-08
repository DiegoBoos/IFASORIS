import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

abstract class FichaRepository {
  Future<Either<Failure, String>> createFichaRepository();
}
