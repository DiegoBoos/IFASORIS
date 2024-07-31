import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tenencia_vivienda.dart';
import '../../repositories/tenencia_vivienda/tenencia_vivienda_repository.dart';

class TenenciaViviendaUsecase {
  final TenenciaViviendaRepository repository;

  TenenciaViviendaUsecase(this.repository);

  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaUsecase(int dtoId) {
    return repository.getTenenciasViviendaRepository(dtoId);
  }
}
