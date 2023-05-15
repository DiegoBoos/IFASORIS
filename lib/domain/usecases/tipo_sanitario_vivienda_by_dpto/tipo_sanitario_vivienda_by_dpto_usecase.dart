import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda_entity.dart';
import '../../repositories/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_repository.dart';

class TipoSanitarioViviendaByDptoUsecase {
  final TipoSanitarioViviendaByDptoRepository repository;

  TipoSanitarioViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaByDptoUsecase(int dtoId) {
    return repository.getTiposSanitarioViviendaByDptoRepository(dtoId);
  }
}
