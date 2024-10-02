import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get msg;

  @override
  List<Object?> get props => [];
}

class NoConnection extends Failure {
  @override
  String get msg => "Desculpe! Não há internet!";
}

class ApiFailure extends Failure {
  @override
  String get msg => "Desculpe, erro no servidor. Tente novamente mais tarde";
}

class AuthFailure extends Failure {
  final String message;
  AuthFailure(this.message);
  
  @override
  String get msg => message;

}