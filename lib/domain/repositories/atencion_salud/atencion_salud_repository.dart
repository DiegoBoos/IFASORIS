import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/atencion_salud_entity.dart';

abstract class AtencionSaludRepository {
  Future<Either<Failure, AtencionSaludEntity>> uploadAtencionSaludRepository();
}
