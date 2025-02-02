import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/costo_desplazamiento.dart';

abstract class CostoDesplazamientoRepository {
  Future<Either<Failure, List<CostoDesplazamientoEntity>>>
      getCostosDesplazamientoRepository();
}
