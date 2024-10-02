import 'package:dartz/dartz.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/data/models/pessoa_model.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';

abstract class ListaPessoasRepository {
  Future<Either<Failure, List<PessoaModel>>> fetchListaPessoas();

  Future<Either<Failure, String>> deletePessoa(String id);

  Future<Either<Failure, List<PessoaModel>>> addPessoa(Pessoa pessoa);
}