import 'dart:async';
import 'package:ricardo_peres/core/auth_service.dart';
import 'package:ricardo_peres/presentation/bloc/splash/splash_event.dart';
import 'package:ricardo_peres/presentation/bloc/splash/splash_state.dart';

class SplashBloc {
  AuthService authService;
  SplashBloc({required this.authService}) {
    _inputController.stream.listen(_blocEventController);
  }

  final StreamController<SplashEvent> _inputController =
      StreamController<SplashEvent>();

  final StreamController<SplashState> _outputController =
      StreamController<SplashState>();

  Sink<SplashEvent> get input => _inputController.sink;
  Stream<SplashState> get stream => _outputController.stream;

  void _blocEventController(SplashEvent event) {
    if (event is IsAuthEvent) {
      _outputController.add(LoadingSplashState());
      if (authService.instance.currentUser != null) {
        _outputController.add(const SuccessSplashState(route: "/listaPessoas"));
        print("sucess");
      } else {
        print("error");
        _outputController.add(const ErrorSplashState(route: "/auth"));
      }
    }
  }
}
