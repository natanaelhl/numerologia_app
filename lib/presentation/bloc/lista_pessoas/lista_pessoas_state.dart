import 'package:equatable/equatable.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';

abstract class ListaPessoasState extends Equatable {
  const ListaPessoasState();

  @override
  List<Object?> get props => [];
}

class SuccessListaPessoasState extends ListaPessoasState {
  final List<Pessoa> listaPessoas;

  const SuccessListaPessoasState({required this.listaPessoas});

  @override
  List<Object?> get props => [listaPessoas];
}

class ErrorListaPessoasState extends ListaPessoasState {
  final String msg;

  const ErrorListaPessoasState({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class LoadingListaPessoasState extends ListaPessoasState {}
