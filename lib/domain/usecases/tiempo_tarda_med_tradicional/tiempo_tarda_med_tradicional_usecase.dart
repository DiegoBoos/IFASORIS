import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tiempo_tarda_med_tradicional.dart';
import '../../repositories/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_repository.dart';

class TiempoTardaMedTradicionalUsecase {
  final TiempoTardaMedTradicionalRepository repository;

  TiempoTardaMedTradicionalUsecase(this.repository);

  Future<Either<Failure, List<TiempoTardaMedTradicionalEntity>>>
      getTiemposTardaMedTradicionalUsecase() {
    return repository.getTiemposTardaMedTradicionalRepository();
  }
}
