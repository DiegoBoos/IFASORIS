import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lengua_maneja.dart';

abstract class LenguaManejaRepository {
  Future<Either<Failure, List<LenguaManejaEntity>>>
      getLenguasManejaRepository();
}
