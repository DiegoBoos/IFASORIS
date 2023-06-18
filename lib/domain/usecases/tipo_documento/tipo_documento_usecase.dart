import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_documento_entity.dart';
import '../../repositories/tipo_documento/tipo_documento_repository.dart';

class TipoDocumentoUsecase {
  final TipoDocumentoRepository repository;

  TipoDocumentoUsecase(this.repository);

  Future<Either<Failure, List<TipoDocumentoEntity>>>
      getTiposDocumentoUsecase() {
    return repository.getTiposDocumentoRepository();
  }
}
