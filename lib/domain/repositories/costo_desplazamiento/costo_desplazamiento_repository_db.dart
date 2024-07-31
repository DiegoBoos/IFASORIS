import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/costo_desplazamiento.dart';

abstract class CostoDesplazamientoRepositoryDB {
  Future<Either<Failure, int>> saveCostoDesplazamientoRepositoryDB(
      CostoDesplazamientoEntity costoDesplazamiento);

  Future<Either<Failure, List<CostoDesplazamientoEntity>>>
      getCostosDesplazamientoRepositoryDB();
}
