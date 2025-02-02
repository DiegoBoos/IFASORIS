import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/piso_vivienda.dart';

abstract class PisoViviendaRepository {
  Future<Either<Failure, List<PisoViviendaEntity>>> getPisosViviendaRepository(
      int dtoId);
}
