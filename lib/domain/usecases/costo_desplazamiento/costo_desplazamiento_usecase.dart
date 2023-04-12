import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/costo_desplazamiento_entity.dart';
import '../../repositories/costo_desplazamiento/costo_desplazamiento_repository.dart';

class CostoDesplazamientoUsecase {
  final CostoDesplazamientoRepository repository;

  CostoDesplazamientoUsecase(this.repository);

  Future<Either<Failure, List<CostoDesplazamientoEntity>>>
      getCostosDesplazamientoUsecase() {
    return repository.getCostosDesplazamientoRepository();
  }
}
