import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_regimen.dart';

abstract class TipoRegimenRepository {
  Future<Either<Failure, List<TipoRegimenEntity>>> getTipoRegimenesRepository();
}
