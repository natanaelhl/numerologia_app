import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class SuccessAuthState extends AuthState {
  final UserCredential userCredential;
  const SuccessAuthState({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class ErrorAuthState extends AuthState {
  final String msg;
  const ErrorAuthState({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class LoadingAuthState extends AuthState {}
