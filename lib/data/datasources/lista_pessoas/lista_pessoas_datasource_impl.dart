import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricardo_peres/core/auth_service.dart';
import 'package:ricardo_peres/core/database_service.dart';
import 'package:ricardo_peres/core/failure.dart';
import 'package:ricardo_peres/data/datasources/lista_pessoas/lista_pessoas_datasource.dart';
import 'package:ricardo_peres/data/models/pessoa_model.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';

class ListaPessoasDatasourceImpl implements ListaPessoasDatasource {
  final DatabaseService dbService;
  final AuthService authService;
  const ListaPessoasDatasourceImpl(
      {required this.dbService, required this.authService});

  @override
  Future<List<PessoaModel>> fetchListaPessoas() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> result = await dbService
          .instance
          .collection("usuarios")
          .doc("UrR7TkL25xWekLfaJYTcyrnUGXm2")
          .collection("pessoas")
          .orderBy("time", descending: true)
          .get();

      List<PessoaModel> listaPessoas =
          result.docs.map((e) => PessoaModel.fromJson(e)).toList();

      return listaPessoas;
    } catch (e) {
      throw ApiFailure();
    }
  }

  @override
  Future<String> deletePessoa(String id) async {
    try {
      dbService.instance
          .collection("usuarios")
          .doc("UrR7TkL25xWekLfaJYTcyrnUGXm2")
          .collection("pessoas")
          .doc(id)
          .delete();
      return id;
    } catch (e) {
      throw ApiFailure();
    }
  }

  @override
  Future<List<PessoaModel>> addPessoa(Pessoa pessoa) async {
    try {
      final doc = dbService.instance
          .collection("usuarios")
          .doc("UrR7TkL25xWekLfaJYTcyrnUGXm2")
          .collection("pessoas")
          .doc();
      final PessoaModel resultado = PessoaModel(
          nome: pessoa.nome, nascimento: pessoa.nascimento, id: doc.id);
      doc.set({
        "nome": pessoa.nome,
        "nascimento": pessoa.nascimento,
        "id": doc.id,
        "time": Timestamp.now()
      });

      var result = fetchListaPessoas();

      return result;
    } catch (e) {
      throw ApiFailure();
    }
  }
}
