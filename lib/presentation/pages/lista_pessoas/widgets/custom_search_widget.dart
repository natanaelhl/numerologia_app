import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/widgets/text_field_custom_widget.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/pessoa_page.dart';

class CustomSearchWidget extends StatefulWidget {
  final List<Pessoa> listaPessoas;
  const CustomSearchWidget({super.key, required this.listaPessoas});

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {

  late OverlayEntry _overlayEntry;

  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned.fill(child: GestureDetector(onTap: () => _hideOverlay()));
    });
    Overlay.of(context).insert(_overlayEntry);
  }

  void _hideOverlay() {
    _overlayEntry.remove();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    List<Pessoa> listaTeste = [
      const Pessoa(nome: "NATANAEL", nascimento: "26081999"),
      const Pessoa(nome: "BRUNO", nascimento: "26081999")
    ];
    return Autocomplete<Pessoa>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Pessoa>.empty();
        }
        return listaTeste.where((Pessoa pessoa) {
          return pessoa.nome!
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption: (Pessoa pessoa) => pessoa.nome!,
      onSelected: (Pessoa selection) {
        debugPrint('You just selected ${selection.nome}');
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFieldCustomWidget(
          onChanged: (_) => _showOverlay(context),
          hintText: "Nome completo",
          controller: textEditingController,
          focusNode: focusNode,
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<Pessoa> onSelected, Iterable<Pessoa> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 4.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width -
                      32, // Respeita o padding de 16 de cada lado
                ),
              
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Pessoa option = options.elementAt(index);
                    return ListTile(
                      title: Text(option.nome!),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PessoaPage(
                                  pessoa: option,
                                )));
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
