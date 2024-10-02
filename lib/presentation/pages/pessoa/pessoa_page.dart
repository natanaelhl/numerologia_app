import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/widgets/custom_app_bar_widget.dart';
import 'package:ricardo_peres/core/widgets/custom_person_info_bar.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/numeros/data_info.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/widgets/custom_widget_accordion.dart';

class PessoaPage extends StatefulWidget {
  final Pessoa? pessoa;
  const PessoaPage({super.key, this.pessoa});

  @override
  State<PessoaPage> createState() => _PessoaPageState();
}

class _PessoaPageState extends State<PessoaPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String nome = DataInfo.formatName(widget.pessoa!.nome!);
    return Scaffold(
      appBar: CustomAppBarWidget(isbackbutton: true,),
      body: Builder(builder: (context){
        
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CustomPersonInfoBar(pessoa: widget.pessoa!,),
                CustomWidgetAccordion(nome: nome, nascimento: widget.pessoa!.nascimento!,)
              ],),
            ),
          );
        
      }));
  }
}


