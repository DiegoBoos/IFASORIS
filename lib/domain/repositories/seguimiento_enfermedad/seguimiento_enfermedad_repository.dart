import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/seguimiento_enfermedad.dart';

abstract class SeguimientoEnfermedadRepository {
  Future<Either<Failure, List<SeguimientoEnfermedadEntity>>>
      getSeguimientoEnfermedadesRepository();
}
