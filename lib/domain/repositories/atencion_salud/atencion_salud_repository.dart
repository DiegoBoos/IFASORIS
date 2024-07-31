import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/atencion_salud.dart';

abstract class AtencionSaludRepository {
  Future<Either<Failure, AtencionSaludEntity>> uploadAtencionSaludRepository();
}
