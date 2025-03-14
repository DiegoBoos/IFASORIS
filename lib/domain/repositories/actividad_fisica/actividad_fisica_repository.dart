import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/actividad_fisica_entity.dart';

abstract class ActividadFisicaRepository {
  Future<Either<Failure, List<ActividadFisicaEntity>>>
      getActividadesFisicasRepository();
}
