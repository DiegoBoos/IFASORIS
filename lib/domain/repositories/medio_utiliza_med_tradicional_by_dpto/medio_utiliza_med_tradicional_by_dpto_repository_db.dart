import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_utiliza_med_tradicional_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_entity.dart';

abstract class MedioUtilizaMedTradicionalByDptoRepositoryDB {
  Future<Either<Failure, int>> saveMedioUtilizaMedTradicionalByDptoRepositoryDB(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicional);

  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalByDptoRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionMediosMedTradicionalRepositoryDB(
      int ubicacionId, List<LstMediosMedTradicional> lstMediosMedTradicional);

  Future<Either<Failure, List<LstMediosMedTradicional>>>
      getMediosUtilizaMedTradicionalRepositoryDB(int? ubicacionId);
}
