import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_familiar.dart';

abstract class GrupoFamiliarRepository {
  Future<Either<Failure, GrupoFamiliarEntity>> uploadGrupoFamiliarRepository();
}
