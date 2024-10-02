import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Pessoa extends Equatable {
  final String? nome;
  final String? nascimento;
  final String? id;
  final Timestamp? time;

  const Pessoa({this.nome, this.nascimento, this.id, this.time});
  @override
  List<Object?> get props => [
        nome,
        nascimento,
        id,
      ];
}
