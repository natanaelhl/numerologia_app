import 'package:equatable/equatable.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';

class ListaPessoasEvent extends Equatable {
  const ListaPessoasEvent();
  @override
  List<Object?> get props => [];
}

class FetchListaPessoasEvent extends ListaPessoasEvent {}

class DeletePessoaEvent extends ListaPessoasEvent {
  final String id;
  const DeletePessoaEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class AddPessoaEvent extends ListaPessoasEvent {
  final Pessoa pessoa;
  const AddPessoaEvent({required this.pessoa});

  @override
  List<Object?> get props => [pessoa];
}
