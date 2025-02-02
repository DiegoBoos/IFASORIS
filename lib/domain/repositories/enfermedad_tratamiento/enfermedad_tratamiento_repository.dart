import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_tratamiento.dart';

abstract class EnfermedadTratamientoRepository {
  Future<Either<Failure, List<EnfermedadTratamientoEntity>>>
      getEnfermedadesTratamientoRepository();
}
