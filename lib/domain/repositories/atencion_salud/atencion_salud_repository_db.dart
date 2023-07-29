import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/atencion_salud_entity.dart';

abstract class AtencionSaludRepositoryDB {
  Future<Either<Failure, int>> saveAtencionSaludRepositoryDB(
      AtencionSaludEntity atencionSalud);

  Future<Either<Failure, AtencionSaludEntity?>> getAtencionSaludRepositoryDB(
      int afiliadoId);
}
