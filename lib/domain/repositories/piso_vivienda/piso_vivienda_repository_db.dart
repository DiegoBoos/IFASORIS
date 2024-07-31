import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/piso_vivienda.dart';
import '../../entities/piso_vivienda.dart';

abstract class PisoViviendaRepositoryDB {
  Future<Either<Failure, int>> savePisoViviendaRepositoryDB(
      PisoViviendaEntity pisoVivienda);

  Future<Either<Failure, List<PisoViviendaEntity>>>
      getPisosViviendaRepositoryDB();

  Future<Either<Failure, List<LstPiso>>> getPisosViviendaViviendaRepositoryDB(
      int? datoViviendaId);

  Future<Either<Failure, int>> savePisosViviendaRepositoryDB(
      int datoViviendaId, List<LstPiso> lstPiso);
}
