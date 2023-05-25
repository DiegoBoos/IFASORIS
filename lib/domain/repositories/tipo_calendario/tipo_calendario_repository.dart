import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_calendario_entity.dart';

abstract class TipoCalendarioRepository {
  Future<Either<Failure, List<TipoCalendarioEntity>>>
      getTiposCalendarioRepository();
}
