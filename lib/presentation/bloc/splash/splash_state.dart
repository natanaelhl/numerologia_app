import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SuccessSplashState extends SplashState {
  final String route;

  const SuccessSplashState({required this.route});

  @override
  List<Object?> get props => [route];
}

class ErrorSplashState extends SplashState {
  final String route;

  const ErrorSplashState({required this.route});

  @override
  List<Object?> get props => [route];
}

class LoadingSplashState extends SplashState {}
