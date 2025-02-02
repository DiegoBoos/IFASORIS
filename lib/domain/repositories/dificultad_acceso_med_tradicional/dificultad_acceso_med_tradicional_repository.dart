import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_med_tradicional.dart';

abstract class DificultadAccesoMedTradicionalRepository {
  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalRepository(int dtoId);
}
