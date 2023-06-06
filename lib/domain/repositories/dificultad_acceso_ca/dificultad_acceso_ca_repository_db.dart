import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/dificultad_acceso_ca_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_ca_entity.dart';

abstract class DificultadAccesoCARepositoryDB {
  Future<Either<Failure, int>> saveDificultadAccesoCARepositoryDB(
      DificultadAccesoCAEntity dificultadAccesoCA);

  Future<Either<Failure, List<DificultadAccesoCAEntity>>>
      getDificultadesAccesoCARepositoryDB();

  Future<Either<Failure, int>> saveUbicacionDificultadesAccesoRepositoryDB(
      int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion);

  Future<Either<Failure, List<LstDificultadAccesoAtencion>>>
      getUbicacionDificultadesAccesoRepositoryDB(int? ubicacionId);
}
