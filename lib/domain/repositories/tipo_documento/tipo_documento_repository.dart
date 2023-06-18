import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_documento_entity.dart';

abstract class TipoDocumentoRepository {
  Future<Either<Failure, List<TipoDocumentoEntity>>>
      getTiposDocumentoRepository();
}
