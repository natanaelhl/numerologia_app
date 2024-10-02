import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/descricoes/arcanos.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/descricoes/ciclo.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/descricoes/destino.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/descricoes/impressao.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/descricoes/motivacao.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/numeros/arcano.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/numeros/numeros_simples.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/styles/pessoa_style.dart';

class CustomWidgetAccordion extends StatelessWidget {
  final String nome;
  final String nascimento;
  const CustomWidgetAccordion({super.key, required this.nome, required this.nascimento});

  @override
  Widget build(BuildContext context) {

    Map<String, int> motivacao = NumerosSimples.motivacao(nome);
    Map<String, int> impressao = NumerosSimples.impressao(nome: nome);
    Map<String, int> expressao = NumerosSimples.expressao(nome: nome);
    Map<String, int> destino = NumerosSimples.destino(data: nascimento);
    Map<String, int> missao = NumerosSimples.missao(
        destino: destino["final"]!, expressao: expressao["final"]!);
    Map<String, int> talentoOculto = NumerosSimples.talentoOculto(
        expressao: expressao["final"]!, motivacao: motivacao["final"]!);
    Map<String, int> numeroPsiquico =
        NumerosSimples.numeroPsiquico(data: nascimento);
    Map<String, int> primeiroCiclo = NumerosSimples.primeiroCiclo(
        data: nascimento, destino: destino["final"]!);
    Map segundoCiclo = NumerosSimples.segundoCiclo(
        data: nascimento,
        finalPrimeiroCiclo: primeiroCiclo["final_ciclo"]!);
    Map terceiroCiclo = NumerosSimples.terceiroCiclo(
        data: nascimento,
        finalSegundoCiclo: segundoCiclo["final_ciclo"]!);
    Map arcano =
        Arcano.obterArcano(data: nascimento, nome: nome);

    return Accordion(
        headerBorderColor: Colors.blueGrey,
        headerBackgroundColorOpened: Colors.green,
        contentBackgroundColor: Colors.white,
        contentBorderColor: Colors.green,
        contentBorderWidth: 3,
        contentHorizontalPadding: 20,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: [
          _arcanoSection(arcano),
          _motivacaoSection(motivacao),
          _destinoSection(destino),
          _impressaoSection(impressao),
          _primeiroCicloSection(primeiroCiclo),
        ]);
  }

  AccordionSection _arcanoSection(Map arcano) {
    return AccordionSection(
      headerBorderColor: ColorPallete.greyColor,
      headerBorderColorOpened: ColorPallete.greyColor,
      headerBorderWidth: 2,
      contentBorderColor: ColorPallete.greyColor,
      isOpen: false,
      headerBackgroundColor: Colors.white,
      rightIcon: Container(
          decoration: BoxDecoration(
              color: ColorPallete.yellowColor,
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
              child: Icon(
            Icons.expand_more,
            color: Colors.white,
          ))),
      header: Row(
        children: [
          Text("Arcano Atual:", style: PessoaStyles.accordionSectionTitle()),
          const SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: ColorPallete.primaryColor,
                borderRadius: BorderRadius.circular(20)),
            child: Text("${arcano["arcano"][0]}",
                style: PessoaStyles.accordionSectionAtribute()),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      content: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: ColorPallete.primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text("Inicio: ${arcano["inicio"]}",
                    style: PessoaStyles.accordionSectionAtribute()),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: ColorPallete.primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text("Término: ${arcano["final"]}",
                    style: PessoaStyles.accordionSectionAtribute()),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(Arcanos.descricao()["${arcano["arcano"][0]}"] ??
              "Não encontrado"),
        ],
      ),
    );
  }

  AccordionSection _motivacaoSection(Map motivacao) {
    return AccordionSection(
        headerBorderColor: ColorPallete.greyColor,
        headerBorderColorOpened: ColorPallete.greyColor,
        headerBorderWidth: 2,
        contentBorderColor: ColorPallete.greyColor,
        isOpen: false,
        headerBackgroundColor: Colors.white,
        rightIcon: Container(
            decoration: BoxDecoration(
                color: ColorPallete.yellowColor,
                borderRadius: BorderRadius.circular(50)),
            child: const Center(
                child: Icon(
              Icons.expand_more,
              color: Colors.white,
            ))),
        header: Row(
          children: [
            Text("Motivação:", style: PessoaStyles.accordionSectionTitle()),
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorPallete.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text("${motivacao["final"]}(${motivacao["grupo"]})",
                  style: PessoaStyles.accordionSectionAtribute()),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        content: Text(
            "${Motivacao.descricao()["${motivacao["final"]}"] ?? "Não encontrado"}"));
  }

  AccordionSection _destinoSection(Map destino) {
    return AccordionSection(
        headerBorderColor: ColorPallete.greyColor,
        headerBorderColorOpened: ColorPallete.greyColor,
        headerBorderWidth: 2,
        contentBorderColor: ColorPallete.greyColor,
        isOpen: false,
        headerBackgroundColor: Colors.white,
        rightIcon: Container(
            decoration: BoxDecoration(
                color: ColorPallete.yellowColor,
                borderRadius: BorderRadius.circular(50)),
            child: const Center(
                child: Icon(
              Icons.expand_more,
              color: Colors.white,
            ))),
        header: Row(
          children: [
            Text("Destino:", style: PessoaStyles.accordionSectionTitle()),
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorPallete.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text("${destino["final"]}(${destino["grupo"]})",
                  style: PessoaStyles.accordionSectionAtribute()),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        content: Text(
            "${Destino.descricao()["${destino["final"]}"] ?? "Não encontrado"}"));
  }

  AccordionSection _impressaoSection(Map impressao) {
    return AccordionSection(
        headerBorderColor: ColorPallete.greyColor,
        headerBorderColorOpened: ColorPallete.greyColor,
        headerBorderWidth: 2,
        contentBorderColor: ColorPallete.greyColor,
        isOpen: false,
        headerBackgroundColor: Colors.white,
        rightIcon: Container(
            decoration: BoxDecoration(
                color: ColorPallete.yellowColor,
                borderRadius: BorderRadius.circular(50)),
            child: const Center(
                child: Icon(
              Icons.expand_more,
              color: Colors.white,
            ))),
        header: Row(
          children: [
            Text("Impressão:", style: PessoaStyles.accordionSectionTitle()),
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorPallete.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text("${impressao["final"]}(${impressao["grupo"]})",
                  style: PessoaStyles.accordionSectionAtribute()),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        content: Text(
            "${Impressao.descricao()["${impressao["final"]}"] ?? "Não encontrado"}"));
  }
  AccordionSection _primeiroCicloSection(Map ciclo) {
    return AccordionSection(
        headerBorderColor: ColorPallete.greyColor,
        headerBorderColorOpened: ColorPallete.greyColor,
        headerBorderWidth: 2,
        contentBorderColor: ColorPallete.greyColor,
        isOpen: false,
        headerBackgroundColor: Colors.white,
        rightIcon: Container(
            decoration: BoxDecoration(
                color: ColorPallete.yellowColor,
                borderRadius: BorderRadius.circular(50)),
            child: const Center(
                child: Icon(
              Icons.expand_more,
              color: Colors.white,
            ))),
        header: Row(
          children: [
            Text("1° Ciclo:", style: PessoaStyles.accordionSectionTitle()),
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorPallete.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text("${ciclo["ciclo"]}",
                  style: PessoaStyles.accordionSectionAtribute()),
            ),
            const SizedBox(width: 8,),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorPallete.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text("${ciclo["inicio_ciclo"]} > ${ciclo["final_ciclo"]}",
                  style: PessoaStyles.accordionSectionAtribute()),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        content: Text(
            "${Ciclo.description()["${ciclo["ciclo"]}"] ?? "Não encontrado"}"));
  }
}
