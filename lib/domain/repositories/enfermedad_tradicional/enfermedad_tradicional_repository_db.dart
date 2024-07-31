import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/enfermedad_tradicional.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_tradicional.dart';

abstract class EnfermedadTradicionalRepositoryDB {
  Future<Either<Failure, int>> saveEnfermedadTradicionalRepositoryDB(
      EnfermedadTradicionalEntity enfermedadTradicional);

  Future<Either<Failure, List<EnfermedadTradicionalEntity>>>
      getEnfermedadesTradicionalesRepositoryDB();

  Future<Either<Failure, List<LstEnfermedadTradicional>>>
      getEnfermedadesTradicionalesAtencionSaludRepositoryDB(
          int? atencionSaludId);

  Future<Either<Failure, int>>
      saveEnfermedadesTradicionalesAtencionSaludRepositoryDB(
          int atencionSaludId,
          List<LstEnfermedadTradicional> lstEnfermedadTradicional);
}
