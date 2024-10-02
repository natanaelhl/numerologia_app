import 'package:ricardo_peres/data/models/pessoa_model.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';

abstract class ListaPessoasDatasource {
  Future<List<PessoaModel>> fetchListaPessoas();

  Future<String> deletePessoa(String id);

  Future<List<PessoaModel>> addPessoa(Pessoa pessoa);
}