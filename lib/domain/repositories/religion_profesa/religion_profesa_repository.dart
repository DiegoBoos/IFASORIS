import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/religion_profesa.dart';

abstract class ReligionProfesaRepository {
  Future<Either<Failure, List<ReligionProfesaEntity>>>
      getReligionesProfesaRepository();
}
