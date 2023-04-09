import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_comunicacion_entity.dart';

abstract class MedioComunicacionRepository {
  Future<Either<Failure, List<MedioComunicacionEntity>>>
      getMediosComunicacionRepository();
}
