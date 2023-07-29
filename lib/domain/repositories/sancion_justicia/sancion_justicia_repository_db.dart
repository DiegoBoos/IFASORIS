import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/sancion_justicia_entity.dart';

abstract class SancionJusticiaRepositoryDB {
  Future<Either<Failure, int>> saveSancionJusticiaRepositoryDB(
      SancionJusticiaEntity sancionJusticia);

  Future<Either<Failure, List<SancionJusticiaEntity>>>
      getSancionesJusticiaRepositoryDB();
}
