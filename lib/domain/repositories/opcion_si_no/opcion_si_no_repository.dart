import 'package:dartz/dartz.dart';
import '../../entities/opcion_si_no_entity.dart';

import '../../../core/error/failure.dart';

abstract class OpcionSiNoRepository {
  Future<Either<Failure, List<OpcionSiNoEntity>>> getOpcionesSiNoRepository();
}
