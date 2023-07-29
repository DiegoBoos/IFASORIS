import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/conducta_seguir_entity.dart';

abstract class ConductaSeguirRepository {
  Future<Either<Failure, List<ConductaSeguirEntity>>>
      getConductasSeguirRepository();
}
