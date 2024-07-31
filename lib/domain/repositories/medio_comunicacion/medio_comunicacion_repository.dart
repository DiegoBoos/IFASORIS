import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_comunicacion.dart';

abstract class MedioComunicacionRepository {
  Future<Either<Failure, List<MedioComunicacionEntity>>>
      getMediosComunicacionRepository(int dtoId);
}
