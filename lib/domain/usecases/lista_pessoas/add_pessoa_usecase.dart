import 'package:dartz/dartz.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/data/models/pessoa_model.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';
import 'package:ricardo_peres/domain/repositories/lista_pessoas/lista_pessoas_repository.dart';
import 'package:ricardo_peres/domain/usecases/core/usecase.dart';

class AddPessoaUsecase extends Usecase<List<PessoaModel>, PessoaModel> {
  final ListaPessoasRepository repository;

  AddPessoaUsecase({required this.repository});
  @override
  Future<Either<Failure, List<PessoaModel>>> call(Pessoa parameter) async{
    return repository.addPessoa(parameter);
  }

}