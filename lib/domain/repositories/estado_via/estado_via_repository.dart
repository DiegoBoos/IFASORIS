import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estado_via.dart';

abstract class EstadoViaRepository {
  Future<Either<Failure, List<EstadoViaEntity>>> getEstadoViasRepository();
}
