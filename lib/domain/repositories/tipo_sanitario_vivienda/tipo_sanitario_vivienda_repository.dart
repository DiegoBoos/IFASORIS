import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda.dart';

abstract class TipoSanitarioViviendaRepository {
  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaRepository(int dtoId);
}
