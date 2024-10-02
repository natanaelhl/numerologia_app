import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/container_injection.dart';
import 'package:ricardo_peres/presentation/bloc/splash/splash_bloc.dart';
import 'package:ricardo_peres/presentation/bloc/splash/splash_event.dart';
import 'package:ricardo_peres/presentation/bloc/splash/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashBloc _bloc;
  @override
  void initState() {
    _bloc = getIt<SplashBloc>();
    _bloc.input.add(IsAuthEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream, 
      builder: (context, snapshot){
        SplashState? state = snapshot.data;

        
        if (state is LoadingSplashState){
          print("Loagding");
          return const Center(child: CircularProgressIndicator(),);
        }
        return Container();
      });
  }
}
