import 'dart:async';
import 'package:ricardo_peres/data/models/pessoa_model.dart';
import 'package:ricardo_peres/domain/usecases/core/usecase.dart';
import 'package:ricardo_peres/domain/usecases/lista_pessoas/add_pessoa_usecase.dart';
import 'package:ricardo_peres/domain/usecases/lista_pessoas/delete_pessoa.dart';
import 'package:ricardo_peres/domain/usecases/lista_pessoas/fetch_lista_pessoas_usecase.dart';
import 'package:ricardo_peres/presentation/bloc/lista_pessoas/lista_pessoas_event.dart';
import 'package:ricardo_peres/presentation/bloc/lista_pessoas/lista_pessoas_state.dart';

class ListaPessoasBloc {
  final FetchListaPessoasUsecase fetchListaPessoas;
  final DeletePessoaUsecase deletePessoa;
  final AddPessoaUsecase addpessoa;

  late List<PessoaModel> listaPessoas;
  ListaPessoasBloc(
      {required this.fetchListaPessoas,
      required this.deletePessoa,
      required this.addpessoa}) {
    listaPessoas = [];

    _inputController.stream.listen(_blocEventController);
  }

  final StreamController<ListaPessoasEvent> _inputController =
      StreamController<ListaPessoasEvent>();

  final StreamController<ListaPessoasState> _outputController =
      StreamController<ListaPessoasState>();

  Sink<ListaPessoasEvent> get input => _inputController.sink;
  Stream<ListaPessoasState> get stream => _outputController.stream;

  void _blocEventController(ListaPessoasEvent event) {
    

    if (event is FetchListaPessoasEvent) {
      fetchListaPessoas(NoParameter()).then((value) => value.fold(
              (l) => _outputController
                  .add(const ErrorListaPessoasState(msg: "Erro")), (r) {
            listaPessoas = r;

            _outputController
                .add(SuccessListaPessoasState(listaPessoas: listaPessoas));
          }));
    } else if (event is DeletePessoaEvent) {
      deletePessoa(event.id).then((value) => value.fold((l) {
            _outputController.add(const ErrorListaPessoasState(msg: "Erro"));
          }, (r) {
            int index = listaPessoas.indexWhere((pessoa) => pessoa.id == r);
            listaPessoas.removeAt(index);
            _outputController
                .add(SuccessListaPessoasState(listaPessoas: listaPessoas));
          }));
    } else if (event is AddPessoaEvent) {
      _outputController.add(LoadingListaPessoasState());
      addpessoa(event.pessoa).then((value) => value.fold((l) {}, (r) {
        listaPessoas = r;
        _outputController.add(SuccessListaPessoasState(listaPessoas: r));
          }));
    }
  }
}
