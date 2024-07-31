import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda.dart';
import '../../repositories/tipo_sanitario_vivienda/tipo_sanitario_vivienda_repository.dart';

class TipoSanitarioViviendaUsecase {
  final TipoSanitarioViviendaRepository repository;

  TipoSanitarioViviendaUsecase(this.repository);

  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaUsecase(int dtoId) {
    return repository.getTiposSanitarioViviendaRepository(dtoId);
  }
}
