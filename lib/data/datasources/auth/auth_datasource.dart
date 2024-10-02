import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricardo_peres/domain/entities/usuario.dart';

abstract class AuthDatasource {
  Future<UserCredential> authSignIn(Usuario usuario);
  Future<UserCredential> authSignUp(Usuario usuario);
}