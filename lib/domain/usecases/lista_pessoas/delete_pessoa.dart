import 'package:dartz/dartz.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/domain/repositories/lista_pessoas/lista_pessoas_repository.dart';
import 'package:ricardo_peres/domain/usecases/core/usecase.dart';

class DeletePessoaUsecase extends Usecase<String, String>{
  final ListaPessoasRepository repository;

  DeletePessoaUsecase({required this.repository});
  
  @override
  Future<Either<Failure, String>> call(parameter) {
    return repository.deletePessoa(parameter);
  }

 
}