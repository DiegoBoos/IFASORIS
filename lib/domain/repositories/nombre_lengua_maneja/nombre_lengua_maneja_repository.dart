import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_lengua_maneja_entity.dart';

abstract class NombreLenguaManejaRepository {
  Future<Either<Failure, List<NombreLenguaManejaEntity>>>
      getNombresLenguasManejaRepository();
}
