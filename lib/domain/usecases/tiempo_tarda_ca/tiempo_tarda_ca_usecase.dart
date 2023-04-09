import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tiempo_tarda_ca_entity.dart';
import '../../repositories/tiempo_tarda_ca/tiempo_tarda_ca_repository.dart';

class TiempoTardaCAUsecase {
  final TiempoTardaCARepository repository;

  TiempoTardaCAUsecase(this.repository);

  Future<Either<Failure, List<TiempoTardaCAEntity>>>
      getTiemposTardaCAUsecase() {
    return repository.getTiemposTardaCARepository();
  }
}
