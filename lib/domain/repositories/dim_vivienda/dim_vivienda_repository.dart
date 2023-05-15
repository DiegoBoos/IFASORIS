import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_vivienda_entity.dart';

abstract class DimViviendaRepository {
  Future<Either<Failure, DimViviendaEntity>> uploadDimViviendaRepository();
}
