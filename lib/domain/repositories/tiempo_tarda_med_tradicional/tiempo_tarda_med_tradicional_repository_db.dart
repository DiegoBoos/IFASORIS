import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tiempo_tarda_med_tradicional_entity.dart';

abstract class TiempoTardaMedTradicionalRepositoryDB {
  Future<Either<Failure, int>> saveTiempoTardaMedTradicionalRepositoryDB(
      TiempoTardaMedTradicionalEntity tiempoTardaMedTradicional);

  Future<Either<Failure, List<TiempoTardaMedTradicionalEntity>>>
      getTiemposTardaMedTradicionalRepositoryDB();
}
