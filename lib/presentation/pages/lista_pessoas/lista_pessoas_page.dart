import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';
import 'package:ricardo_peres/core/container_injection.dart';
import 'package:ricardo_peres/core/widgets/custom_person_info_bar.dart';
import 'package:ricardo_peres/core/widgets/text_field_custom_widget.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';
import 'package:ricardo_peres/presentation/bloc/lista_pessoas/lista_pessoas_bloc.dart';
import 'package:ricardo_peres/presentation/bloc/lista_pessoas/lista_pessoas_event.dart';
import 'package:ricardo_peres/presentation/bloc/lista_pessoas/lista_pessoas_state.dart';
import 'package:ricardo_peres/presentation/pages/lista_pessoas/styles/lista_pessoas_styles.dart';
import 'package:ricardo_peres/presentation/pages/lista_pessoas/widgets/custom_search_widget.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/pessoa_page.dart';

class ListaPessoasPage extends StatefulWidget {
  final UserCredential? userCredential;
  const ListaPessoasPage({super.key, this.userCredential});

  @override
  State<ListaPessoasPage> createState() => _ListaPessoasPageState();
}

class _ListaPessoasPageState extends State<ListaPessoasPage> {
  late ListaPessoasBloc _bloc;
  @override
  void initState() {
    _bloc = getIt<ListaPessoasBloc>();
    _bloc.input.add(FetchListaPessoasEvent());
    super.initState();
  }

  List<Pessoa> listaPessoas = [];

  TextEditingController listaPessoasController = TextEditingController();

  TextEditingController nomePacienteController = TextEditingController();
  TextEditingController dataPacienteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          ListaPessoasState? state = snapshot.data;
          if (state is SuccessListaPessoasState) {
            listaPessoas = state.listaPessoas;
          } else if (state is LoadingListaPessoasState) {
            print("Loading...");
          }
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color.fromARGB(255, 243, 241, 241),
              appBar: AppBar(backgroundColor: ColorPallete.primaryColor,),
              
              drawer: Drawer(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Row(
                      children: [
                        CircleAvatar(child: Icon(Icons.person)),
                        SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nome do Usuário',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            Text('email@example.com',
                                style: TextStyle(color: Colors.white70))
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Perfil'),
                    onTap: () {
                      Navigator.pushNamed(context, "/profilePage");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Configurações'),
                    onTap: () {/* Lógica de navegação */},
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Sair'),
                    onTap: () {/* Lógica de logout */},
                  ),
                ],
              )),
              body: Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Pesquisar",
                              style: ListaPessoasStyles.title(),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child:
                                CustomSearchWidget(listaPessoas: listaPessoas),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Atalhos",
                              style: ListaPessoasStyles.title(),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showMyAlertDialog(context);
                                  },
                                  child: _buildShortcutButton(
                                      const Icon(
                                        Icons.person_add,
                                        color: Colors.white,
                                      ),
                                      "Adicionar Paciênte"),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Últimos paciêntes adicionados",
                              style: ListaPessoasStyles.title(),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                color: Colors.white),
                            height: 380,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: listaPessoas.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => PessoaPage(
                                                    pessoa: listaPessoas[index],
                                                  )));
                                    },
                                    child: CustomPersonInfoBar(
                                      pessoa: listaPessoas[index],
                                    ));
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ));
        });
  }

  Widget _buildShortcutButton(Widget icon, String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorPallete.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 228, 227, 227)),
            )
          ],
        ),
      ),
    );
  }

  void _showMyAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cadastro de Paciênte',
            style: TextStyle(
                color: ColorPallete.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nome: ",
                  style: TextStyle(
                      color: ColorPallete.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldCustomWidget(
                    hintText: "Nome Completo",
                    controller: nomePacienteController),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Data de nascimento: ",
                  style: TextStyle(
                      color: ColorPallete.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldCustomWidget(
                    hintText: "Data de nascimento",
                    controller: dataPacienteController),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(
                    color: ColorPallete.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                    color: ColorPallete.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                _bloc.input.add(AddPessoaEvent(
                    pessoa: Pessoa(
                        nome: nomePacienteController.text,
                        nascimento: dataPacienteController.text)));
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  Widget _cardButtom({required IconData icon, required String title}) {
    return Container(
      width: 170,
      height: 90,
      decoration: BoxDecoration(
          color: ColorPallete.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
