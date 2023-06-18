import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nivel_educativo_entity.dart';

abstract class NivelEducativoRepositoryDB {
  Future<Either<Failure, int>> saveNivelEducativoRepositoryDB(
      NivelEducativoEntity nivelEducativo);

  Future<Either<Failure, List<NivelEducativoEntity>>>
      getNivelesEducativosRepositoryDB();
}
