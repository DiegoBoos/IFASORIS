import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/failure.dart';
import '../../entities/usuario.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> logInRepository(UsuarioEntity user);

  Future<Either<Failure, User>> registerRepository(UsuarioEntity user);

  Future<Either<Failure, String>> cambioDispositivoRepositoryDB(
      String userName, String idEquipo);
}
