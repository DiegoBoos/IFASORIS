import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tiempo_tarda_ca_entity.dart';

abstract class TiempoTardaCARepositoryDB {
  Future<Either<Failure, int>> saveTiempoTardaCARepositoryDB(
      TiempoTardaCAEntity tiempoTardaCA);

  Future<Either<Failure, List<TiempoTardaCAEntity>>>
      getTiemposTardaCARepositoryDB();
}
