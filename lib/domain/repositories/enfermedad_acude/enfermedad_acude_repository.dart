import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_acude.dart';

abstract class EnfermedadAcudeRepository {
  Future<Either<Failure, List<EnfermedadAcudeEntity>>>
      getEnfermedadesAcudeRepository();
}
