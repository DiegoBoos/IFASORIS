import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/medio_utiliza_ca.dart';
import '../../entities/medio_utiliza_ca.dart';

abstract class MedioUtilizaCARepositoryDB {
  Future<Either<Failure, int>> saveMedioUtilizaCARepositoryDB(
      MedioUtilizaCAEntity medioUtilizaCA);

  Future<Either<Failure, List<MedioUtilizaCAEntity>>>
      getMediosUtilizaCARepositoryDB();

  Future<Either<Failure, List<LstMediosUtilizaCA>>>
      getUbicacionMediosUtilizaCARepositoryDB(int? ubicacionId);

  Future<Either<Failure, int>> saveUbicacionMediosUtilizaCARepositoryDB(
      int datoViviendaId, List<LstMediosUtilizaCA> lstMediosUtilizaCA);
}
