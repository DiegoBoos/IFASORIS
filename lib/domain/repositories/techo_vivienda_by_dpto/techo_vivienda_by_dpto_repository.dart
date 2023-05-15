import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda_entity.dart';

abstract class TechoViviendaByDptoRepository {
  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaByDptoRepository(int dtoId);
}
