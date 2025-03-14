import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_vivienda_entity.dart';

abstract class TipoViviendaRepository {
  Future<Either<Failure, List<TipoViviendaEntity>>> getTiposViviendaRepository(
      int dtoId);
}
