import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_comunicacion.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_comunicacion.dart';

abstract class MedioComunicacionRepositoryDB {
  Future<Either<Failure, int>> saveMedioComunicacionRepositoryDB(
      MedioComunicacionEntity medioComunicacion);

  Future<Either<Failure, List<MedioComunicacionEntity>>>
      getMediosComunicacionRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionMediosComunicacionRepositoryDB(
      int ubicacionId, List<LstMediosComunica> lstMediosComunica);

  Future<Either<Failure, List<LstMediosComunica>>>
      getUbicacionMediosComunicacionRepositoryDB(int? ubicacionId);
}
