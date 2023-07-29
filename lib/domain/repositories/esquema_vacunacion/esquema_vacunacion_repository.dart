import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/esquema_vacunacion_entity.dart';

abstract class EsquemaVacunacionRepository {
  Future<Either<Failure, List<EsquemaVacunacionEntity>>>
      getEsquemasVacunacionRepository();
}
