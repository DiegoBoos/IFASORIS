import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/piso_vivienda_entity.dart';

abstract class PisoViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> savePisoViviendaByDptoRepositoryDB(
      PisoViviendaEntity pisoVivienda);

  Future<Either<Failure, List<PisoViviendaEntity>>>
      getPisosViviendaByDptoRepositoryDB();
}
