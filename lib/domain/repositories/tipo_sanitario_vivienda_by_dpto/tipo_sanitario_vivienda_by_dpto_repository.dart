import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda_entity.dart';

abstract class TipoSanitarioViviendaByDptoRepository {
  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaByDptoRepository(int dtoId);
}
