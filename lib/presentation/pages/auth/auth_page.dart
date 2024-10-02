import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';
import 'package:ricardo_peres/core/container_injection.dart';
import 'package:ricardo_peres/core/widgets/elevated_button_custom_widget.dart';
import 'package:ricardo_peres/core/widgets/text_field_custom_widget.dart';
import 'package:ricardo_peres/domain/entities/usuario.dart';
import 'package:ricardo_peres/presentation/bloc/auth/auth_bloc.dart';
import 'package:ricardo_peres/presentation/bloc/auth/auth_event.dart';
import 'package:ricardo_peres/presentation/bloc/auth/auth_state.dart';
import 'package:ricardo_peres/presentation/pages/auth/styles/auth_styles.dart';
import 'package:ricardo_peres/presentation/pages/lista_pessoas/lista_pessoas_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool signInLockPassword = true;

  bool signUpLockPassword = true;

  TextEditingController signInEmailTextEditingController =
      TextEditingController();
  TextEditingController signInPasswordTextEditingController =
      TextEditingController();

  TextEditingController signUpNameTextEditingController =
      TextEditingController();
  TextEditingController signUpEmailTextEditingController =
      TextEditingController();
  TextEditingController signUpPasswordTextEditingController =
      TextEditingController();

  late AuthBloc _bloc;
  int typeAuth = 0;
  bool isLoading = false;

  @override
  void initState() {
    _bloc = getIt<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget layout = Container();
    double cardWidth = 0;

    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          AuthState? state = snapshot.data;

          Widget body = Container();
          if (state is SuccessAuthState) {
            final UserCredential userCredential = state.userCredential;
            return ListaPessoasPage(userCredential: userCredential);
          } else if (state is LoadingAuthState) {
            isLoading = true;
          } else if (state is ErrorAuthState) {
            isLoading = false;

            showMySnackBar(context, state.msg);
          }
          body = LayoutBuilder(builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            bool isWideScreen = constraints.maxWidth >= 800;
            if (screenWidth >= 800) {
              cardWidth = 800;
            } else if (screenWidth >= 600) {
              cardWidth = 500;
            } else if (screenWidth <= 599) {
              cardWidth = 500;
            }
            Widget form = typeAuth == 0
                ? _signInFormWidget(screenWidth)
                : _signUpFormWidget(screenWidth);
            layout = isWideScreen
                ? Row(
                    children: [
                      Expanded(child: form),
                      Expanded(child: Image.asset("assets/images/logo3.png"))
                    ],
                  )
                : form;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    ColorPallete.primaryColor,
                    ColorPallete.primaryEnd
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Center(
                        child: isWideScreen
                            ? Column(
                                children: [
                                  _customCard(cardWidth, layout),
                                ],
                              )
                            : Column(
                                children: [
                                  Image.asset("assets/images/logo1.png"),
                                  Text(
                                    "Agora ficou simples criar",
                                    style: AuthStyles.tituloContainer,
                                  ),
                                  Text(
                                    "Mapas Numerológicos",
                                    style: AuthStyles.describeContainer,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  _customCard(cardWidth, layout),
                                ],
                              )),
                  ),
                ),
              ),
            );
          });

          return Scaffold(
            backgroundColor: ColorPallete.primaryEnd,
            body: body,
          );
        });
  }

  Widget _signInFormWidget(double largura) {
    return Padding(
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bem vindo",
            style: AuthStyles.tituloContainer,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Preencha as informações para acessar a sua conta.",
            style: AuthStyles.describeContainer,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldCustomWidget(
            controller: signInEmailTextEditingController,
            hintText: "E-mail",
            suffixIcon: const Icon(Icons.email),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldCustomWidget(
            controller: signInPasswordTextEditingController,
            obscureText: signInLockPassword,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    signInLockPassword = !signInLockPassword;
                  });
                },
                child: signInLockPassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
            hintText: "Senha",
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButtonCustomWidget(
                onpress: () {
                  _bloc.input.add(AuthSignInEvent(
                      usuario: Usuario(
                          email: signInEmailTextEditingController.text.isEmpty
                              ? ""
                              : signInEmailTextEditingController.text,
                          senha:
                              signInPasswordTextEditingController.text.isEmpty
                                  ? ""
                                  : signInPasswordTextEditingController.text)));
                },
                color: ColorPallete.primaryColor,
                hoverColor: ColorPallete.primaryColor.withOpacity(0.8),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                    : const Text(
                        "entrar",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
              )),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButtonCustomWidget(
                onpress: () {},
                hoverColor: ColorPallete.greyColor.withOpacity(0.2),
                color: ColorPallete.greyColor.withOpacity(0.3),
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Ainda não tem uma conta?",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    typeAuth = 1;
                  });
                },
                child: const Text(
                  "Criar conta",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _signUpFormWidget(double largura) {
    return Padding(
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Crie sua conta",
            style: AuthStyles.tituloContainer,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Preencha as informações para acessar a sua conta.",
            style: AuthStyles.describeContainer,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldCustomWidget(
            controller: signUpNameTextEditingController,
            hintText: "Nome completo",
            suffixIcon: const Icon(Icons.person),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldCustomWidget(
            controller: signUpEmailTextEditingController,
            hintText: "E-mail",
            suffixIcon: const Icon(Icons.email),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldCustomWidget(
            controller: signUpPasswordTextEditingController,
            obscureText: signUpLockPassword,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    signUpLockPassword = !signUpLockPassword;
                  });
                },
                child: signUpLockPassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
            hintText: "Senha",
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButtonCustomWidget(
                onpress: () {
                  _bloc.input.add(AuthSignUpEvent(
                      usuario: Usuario(
                          name: signUpNameTextEditingController.text.isEmpty
                              ? ""
                              : signUpNameTextEditingController.text,
                          email: signUpEmailTextEditingController.text.isEmpty
                              ? ""
                              : signUpEmailTextEditingController.text,
                          senha:
                              signUpPasswordTextEditingController.text.isEmpty
                                  ? ""
                                  : signUpPasswordTextEditingController.text)));
                },
                color: ColorPallete.primaryColor,
                hoverColor: ColorPallete.primaryColor.withOpacity(0.8),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                    : const Text(
                        "Cadastre-se",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
              )),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Já possui uma conta?",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    typeAuth = 0;
                  });
                },
                child: const Text(
                  "Faça login ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _customCard(double largura, Widget conteudo) {
    return Container(
      width: largura,
      height: 460,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(111, 0, 0, 0).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          conteudo,
        ],
      ),
    );
  }

  Future<void> showMySnackBar(context, String msg) async {
    await Future.delayed(
        Duration.zero); // Garante que o SnackBar seja mostrado após o build
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(child: Text(msg))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 202, 28, 28),
      ),
    );
  }
}
