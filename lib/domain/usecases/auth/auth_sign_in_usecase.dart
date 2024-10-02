import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/domain/entities/usuario.dart';
import 'package:ricardo_peres/domain/repositories/auth/auth_repository.dart';
import 'package:ricardo_peres/domain/usecases/core/usecase.dart';

class AuthSignInUsecase extends Usecase<UserCredential, Usuario>{
  final AuthRepository repository;

  AuthSignInUsecase({required this.repository});

  @override
  Future<Either<Failure, UserCredential>> call(Usuario parameter) {
    return repository.authSignIn(parameter);
  }
}