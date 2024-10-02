import 'package:ricardo_peres/domain/entities/pessoa.dart';

class PessoaModel extends Pessoa {
  const PessoaModel({super.nome, super.nascimento, super.id, super.time});

  factory PessoaModel.fromJson(dynamic json) =>
      PessoaModel(nome: json["nome"], nascimento: json["nascimento"], id: json["id"], time: json["time"]);

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "nascimento": nascimento,
        "id": id,
        "time": time,
      };
}
