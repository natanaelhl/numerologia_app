import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricardo_peres/core/auth_service.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/data/datasources/auth/auth_datasource.dart';
import 'package:ricardo_peres/domain/entities/usuario.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final AuthService authService;
  const AuthDatasourceImpl({required this.authService});
  @override
  Future<UserCredential> authSignIn(Usuario usuario) {
    try {
      var resultado = authService.instance.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
      );
      return resultado;
    } catch (e) {
      throw ApiFailure();
    }
  }

  @override
  Future<UserCredential> authSignUp(Usuario usuario) async {
    try {
      final result = await authService.instance.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
      );

      await result.user?.updateDisplayName(usuario.name);
      return result;
    } catch (e) {
      throw ApiFailure();
    }
  }
}
