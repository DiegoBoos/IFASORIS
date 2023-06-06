import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda_entity.dart';

abstract class TipoSanitarioViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTipoSanitarioViviendaByDptoRepositoryDB(
      TipoSanitarioViviendaEntity tipoSanitarioVivienda);

  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaByDptoRepositoryDB();

  Future<Either<Failure, int>> saveTiposSanitarioViviendaRepositoryDB(
      int datoViviendaId, List<LstTiposSanitario> lstTiposSanitario);

  Future<Either<Failure, List<LstTiposSanitario>>>
      getTiposSanitarioViviendaRepositoryDB(int? datoViviendaId);
}
