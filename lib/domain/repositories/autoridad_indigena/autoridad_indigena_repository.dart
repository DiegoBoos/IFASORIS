import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/autoridad_indigena_entity.dart';

import '../../../core/error/failure.dart';

abstract class AutoridadIndigenaRepository {
  Future<Either<Failure, List<AutoridadIndigenaEntity>>>
      getAutoridadesIndigenasRepository(int dtoId);
}
