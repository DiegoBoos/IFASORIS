import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_combustible_vivienda_entity.dart';

abstract class TipoCombustibleViviendaByDptoRepository {
  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaByDptoRepository(int dtoId);
}
