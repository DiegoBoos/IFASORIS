import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_documento.dart';

abstract class TipoDocumentoRepository {
  Future<Either<Failure, List<TipoDocumentoEntity>>>
      getTiposDocumentoRepository();
}
