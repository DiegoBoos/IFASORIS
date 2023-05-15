import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda_entity.dart';

abstract class TipoSanitarioViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTipoSanitarioViviendaByDptoRepositoryDB(
      TipoSanitarioViviendaEntity tipoSanitarioVivienda);

  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaByDptoRepositoryDB();
}
