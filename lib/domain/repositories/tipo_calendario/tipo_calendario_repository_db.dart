import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_calendario.dart';

abstract class TipoCalendarioRepositoryDB {
  Future<Either<Failure, int>> saveTipoCalendarioRepositoryDB(
      TipoCalendarioEntity tipoCalendario);

  Future<Either<Failure, List<TipoCalendarioEntity>>>
      getTiposCalendarioRepositoryDB();
}
