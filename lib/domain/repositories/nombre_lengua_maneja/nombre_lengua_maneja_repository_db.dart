import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_lengua_maneja_entity.dart';

abstract class NombreLenguaManejaRepositoryDB {
  Future<Either<Failure, int>> saveNombreLenguaManejaRepositoryDB(
      NombreLenguaManejaEntity nombreLenguaManeja);

  Future<Either<Failure, List<NombreLenguaManejaEntity>>>
      getNombresLenguasManejaRepositoryDB();
}
