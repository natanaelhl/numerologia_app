import 'package:dartz/dartz.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/data/models/pessoa_model.dart';
import 'package:ricardo_peres/domain/repositories/lista_pessoas/lista_pessoas_repository.dart';
import 'package:ricardo_peres/domain/usecases/core/usecase.dart';

class FetchListaPessoasUsecase extends Usecase<List<PessoaModel>, NoParameter> {
  final ListaPessoasRepository repository;

  FetchListaPessoasUsecase({required this.repository});
  @override
  Future<Either<Failure, List<PessoaModel>>> call(parameter) {
    return repository.fetchListaPessoas();
  }
}
