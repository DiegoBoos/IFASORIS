import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_enfermedad_entity.dart';

abstract class NombreEnfermedadRepository {
  Future<Either<Failure, List<NombreEnfermedadEntity>>>
      getNombresEnfermedadesRepository();
}
