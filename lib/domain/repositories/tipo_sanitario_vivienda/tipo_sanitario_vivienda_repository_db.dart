import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda_entity.dart';

abstract class TipoSanitarioViviendaRepositoryDB {
  Future<Either<Failure, int>> saveTipoSanitarioViviendaRepositoryDB(
      TipoSanitarioViviendaEntity tipoSanitarioVivienda);

  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioRepositoryDB();

  Future<Either<Failure, int>> saveTiposSanitarioViviendaRepositoryDB(
      int datoViviendaId, List<LstTipoSanitario> lstTipoSanitario);

  Future<Either<Failure, List<LstTipoSanitario>>>
      getTiposSanitarioViviendaRepositoryDB(int? datoViviendaId);
}
