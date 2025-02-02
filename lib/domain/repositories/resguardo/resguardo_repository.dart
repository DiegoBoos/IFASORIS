import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo.dart';

abstract class ResguardoRepository {
  Future<Either<Failure, List<ResguardoEntity>>> getResguardosRepository(
      int dtoId);
}
