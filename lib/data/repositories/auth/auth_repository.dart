import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/usuario.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../datasources/remote/auth_remote_ds.dart';
import '../../models/usuario.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UsuarioModel>> logInRepository(
      UsuarioEntity usuario) async {
    try {
      final result = await authRemoteDataSource.logIn(usuario);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> registerRepository(
      UsuarioEntity usuario) async {
    try {
      final result = await authRemoteDataSource.register(usuario);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }

  @override
  Future<Either<Failure, String>> cambioDispositivoRepositoryDB(
      String userName, String idEquipo) async {
    try {
      final result =
          await authRemoteDataSource.cambioDispositivo(userName, idEquipo);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
