import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/religion_profesa.dart';

abstract class ReligionProfesaRepositoryDB {
  Future<Either<Failure, int>> saveReligionProfesaRepositoryDB(
      ReligionProfesaEntity religionProfesa);

  Future<Either<Failure, List<ReligionProfesaEntity>>>
      getReligionesProfesaRepositoryDB();
}
