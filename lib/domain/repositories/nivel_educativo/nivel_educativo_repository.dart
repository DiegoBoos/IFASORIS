import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nivel_educativo_entity.dart';

abstract class NivelEducativoRepository {
  Future<Either<Failure, List<NivelEducativoEntity>>>
      getNivelesEducativosRepository();
}
