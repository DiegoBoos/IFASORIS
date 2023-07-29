import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/lugar_atencion_medico_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_atencion_medico_entity.dart';

abstract class LugarAtencionMedicoRepositoryDB {
  Future<Either<Failure, int>> saveLugarAtencionMedicoRepositoryDB(
      LugarAtencionMedicoEntity lugarAtencionMedico);

  Future<Either<Failure, List<LugarAtencionMedicoEntity>>>
      getLugaresAtencionMedicoRepositoryDB();

  Future<Either<Failure, List<LstLugarAtencionMedico>>>
      getLugaresAtencionMedicoAtencionSaludRepositoryDB(int? atencionSaludId);

  Future<Either<Failure, int>>
      saveLugaresAtencionMedicoAtencionSaludRepositoryDB(int atencionSaludId,
          List<LstLugarAtencionMedico> lstLugarAtencionMedico);
}
