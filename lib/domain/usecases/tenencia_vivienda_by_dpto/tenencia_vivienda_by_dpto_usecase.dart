import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tenencia_vivienda_entity.dart';
import '../../repositories/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_repository.dart';

class TenenciaViviendaByDptoUsecase {
  final TenenciaViviendaByDptoRepository repository;

  TenenciaViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaByDptoUsecase(int dtoId) {
    return repository.getTenenciasViviendaByDptoRepository(dtoId);
  }
}
