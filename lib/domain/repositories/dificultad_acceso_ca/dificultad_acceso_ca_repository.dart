import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_ca_entity.dart';

abstract class DificultadAccesoCARepository {
  Future<Either<Failure, List<DificultadAccesoCAEntity>>>
      getDificultadesAccesoCARepository();
}
