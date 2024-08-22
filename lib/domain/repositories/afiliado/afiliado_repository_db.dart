import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/afiliado.dart';
import '../../entities/ficha.dart';

abstract class AfiliadoRepositoryDB {
  Future<Either<Failure, List<AfiliadoEntity>>> getAfiliadosRepositoryDB(
      String query);

  Future<Either<Failure, void>> saveAfiliadoRepositoryDB(
      AfiliadoEntity afiliado);

  Future<Either<Failure, FichaEntity?>> afiliadoTieneFichaRepositoryDB(
      int afiliadoId);

  Future<Either<Failure, String>> afiliadoTieneFichaReportadaRepositoryDB(
      int afiliadoId);
}
