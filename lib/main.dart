import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';
import 'package:ricardo_peres/core/container_injection.dart';
import 'package:ricardo_peres/firebase_options.dart';
import 'package:ricardo_peres/presentation/pages/auth/auth_page.dart';
import 'package:ricardo_peres/presentation/pages/lista_pessoas/lista_pessoas_page.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/pessoa_page.dart';
import 'package:ricardo_peres/presentation/pages/splash/splash_page.dart';
import 'package:ricardo_peres/presentation/pages/profile/profile.dart';

void main() async {
  await setupContainer();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: ColorPallete.primaryEnd,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      initialRoute: "/splashPage",
      routes: {
        "/profilePage": (_) => const ProfilePage(),
        "/listaPessoas": (_) => const ListaPessoasPage(),
        "/pessoaPage": (_) => const PessoaPage(),
        "/auth": (_) => const AuthPage(),
        "/splashPage": (_) => const SplashPage()
      },
    );
  }
}
