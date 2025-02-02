import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_lengua_materna.dart';

abstract class NombreLenguaMaternaRepository {
  Future<Either<Failure, List<NombreLenguaMaternaEntity>>>
      getNombresLenguasMaternaRepository(int dtoId);
}
