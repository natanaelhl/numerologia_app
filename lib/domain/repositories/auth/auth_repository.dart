import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/domain/entities/usuario.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> authSignIn(Usuario usuario);
  Future<Either<Failure, UserCredential>> authSignUp(Usuario usuario);
}