import 'package:dartz/dartz.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/data/datasources/lista_pessoas/lista_pessoas_datasource.dart';
import 'package:ricardo_peres/data/models/pessoa_model.dart';
import 'package:ricardo_peres/data/network/network_info.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';
import 'package:ricardo_peres/domain/repositories/lista_pessoas/lista_pessoas_repository.dart';

class ListaPessoasRepositoryImpl implements ListaPessoasRepository {
  final ListaPessoasDatasource datasource;
  final NetworkInfo networkInfo;

  ListaPessoasRepositoryImpl(
      {required this.datasource, required this.networkInfo});

  @override
  Future<Either<Failure, List<PessoaModel>>> fetchListaPessoas() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.fetchListaPessoas();
        return Right(result);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }

  @override
  Future<Either<Failure, String>> deletePessoa(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.deletePessoa(id);

        return Right(result);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }

  @override
  Future<Either<Failure, List<PessoaModel>>> addPessoa(Pessoa pessoa) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.addPessoa(pessoa);

        return Right(result);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }
}
