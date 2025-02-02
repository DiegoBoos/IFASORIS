import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_solicitado.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_solicitado.dart';

abstract class ServicioSolicitadoRepositoryDB {
  Future<Either<Failure, int>> saveServicioSolicitadoRepositoryDB(
      ServicioSolicitadoEntity servicioSolicitado);

  Future<Either<Failure, List<ServicioSolicitadoEntity>>>
      getServiciosSolicitadosRepositoryDB();

  Future<Either<Failure, List<LstServicioSolicitado>>>
      getLstServiciosSolicitadosRepositoryDB(int? cuidadoSaludCondRiesgoId);

  Future<Either<Failure, int>> saveServiciosSolicitadosRepositoryDB(
      int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados);
}
