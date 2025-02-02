import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/sancion_justicia.dart';

abstract class SancionJusticiaRepository {
  Future<Either<Failure, List<SancionJusticiaEntity>>>
      getSancionesJusticiaRepository();
}
