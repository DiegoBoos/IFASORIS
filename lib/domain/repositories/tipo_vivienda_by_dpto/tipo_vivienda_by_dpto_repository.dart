import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_vivienda_entity.dart';

abstract class TipoViviendaByDptoRepository {
  Future<Either<Failure, List<TipoViviendaEntity>>>
      getTiposViviendaByDptoRepository(int dtoId);
}
