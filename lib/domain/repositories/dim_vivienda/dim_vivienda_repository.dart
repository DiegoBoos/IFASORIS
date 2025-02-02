import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_vivienda.dart';

abstract class DimViviendaRepository {
  Future<Either<Failure, DimViviendaEntity>> uploadDimViviendaRepository();
}
