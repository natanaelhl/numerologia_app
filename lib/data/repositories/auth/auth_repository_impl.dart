import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/core/translator_errors.dart';
import 'package:ricardo_peres/data/datasources/auth/auth_datasource.dart';
import 'package:ricardo_peres/data/network/network_info.dart';
import 'package:ricardo_peres/domain/entities/usuario.dart';
import 'package:ricardo_peres/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  final NetworkInfo networkInfo;
  const AuthRepositoryImpl(
      {required this.authDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, UserCredential>> authSignIn(Usuario usuario) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await authDatasource.authSignIn(usuario);

        return Right(result);
      } on Exception catch (e) {
        
        return Left(AuthFailure(TranslatorErrors.build(e.toString())));
      }
    } else {
      return Left(NoConnection());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> authSignUp(Usuario usuario) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await authDatasource.authSignUp(usuario));
      } on Exception catch (e) {
        
        return Left(AuthFailure(TranslatorErrors.build(e.toString())));
      }
    } else {
      return Left(NoConnection());
    }
  }
}
