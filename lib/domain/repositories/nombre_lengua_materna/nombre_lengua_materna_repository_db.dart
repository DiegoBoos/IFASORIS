import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_lengua_materna.dart';

abstract class NombreLenguaMaternaRepositoryDB {
  Future<Either<Failure, int>> saveNombreLenguaMaternaRepositoryDB(
      NombreLenguaMaternaEntity nombreLenguaMaterna);

  Future<Either<Failure, List<NombreLenguaMaternaEntity>>>
      getNombresLenguasMaternaRepositoryDB();
}
