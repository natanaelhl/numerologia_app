import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String? name;
  final String email;
  final String senha;
  const Usuario({required this.email, required this.senha, this.name});
  @override
  
  List<Object?> get props => [email, senha, name];

}