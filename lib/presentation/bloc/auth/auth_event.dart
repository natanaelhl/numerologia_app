import 'package:equatable/equatable.dart';
import 'package:ricardo_peres/domain/entities/usuario.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];
}
class AuthSignUpEvent extends AuthEvent{
  final Usuario usuario;
  const AuthSignUpEvent({required this.usuario});
  @override
  List<Object?> get props => [usuario];
}
class AuthSignInEvent extends AuthEvent{
  final Usuario usuario;
  const AuthSignInEvent({required this.usuario});
  
  @override
  List<Object?> get props => [usuario];
}

class AuthShowRegisterWidgetEvent extends AuthEvent{}

