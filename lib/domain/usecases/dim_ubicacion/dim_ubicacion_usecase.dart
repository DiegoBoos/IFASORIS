import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_ubicacion_entity.dart';
import '../../repositories/dim_ubicacion/dim_ubicacion_repository.dart';

class DimUbicacionUsecase {
  final DimUbicacionRepository repository;

  DimUbicacionUsecase(this.repository);

  Future<Either<Failure, DimUbicacionEntity>> uploadDimUbicacionUsecase() {
    return repository.uploadDimUbicacionRepository();
  }
}
