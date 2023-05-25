import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_calendario_entity.dart';
import '../../repositories/tipo_calendario/tipo_calendario_repository.dart';

class TipoCalendarioUsecase {
  final TipoCalendarioRepository repository;

  TipoCalendarioUsecase(this.repository);

  Future<Either<Failure, List<TipoCalendarioEntity>>>
      getTiposCalendarioUsecase() {
    return repository.getTiposCalendarioRepository();
  }
}
