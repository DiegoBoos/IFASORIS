import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tenencia_vivienda.dart';

abstract class TenenciaViviendaRepository {
  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaRepository(int dtoId);
}
