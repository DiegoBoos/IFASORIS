import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_vivienda_entity.dart';
import '../../repositories/dim_vivienda/dim_vivienda_repository.dart';

class DimViviendaUsecase {
  final DimViviendaRepository repository;

  DimViviendaUsecase(this.repository);

  Future<Either<Failure, DimViviendaEntity>> uploadDimViviendaUsecase() {
    return repository.uploadDimViviendaRepository();
  }
}
