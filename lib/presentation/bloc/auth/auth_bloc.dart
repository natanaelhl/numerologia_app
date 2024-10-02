import 'dart:async';

import 'package:ricardo_peres/domain/usecases/auth/auth_sign_in_usecase.dart';
import 'package:ricardo_peres/domain/usecases/auth/auth_sign_up_usecase.dart';
import 'package:ricardo_peres/presentation/bloc/auth/auth_event.dart';
import 'package:ricardo_peres/presentation/bloc/auth/auth_state.dart';

class AuthBloc {
  final AuthSignInUsecase authSignIn;
  final AuthSignUpUsecase authSignUp;

  AuthBloc({required this.authSignIn, required this.authSignUp}) {
    _inputController.stream.listen(_blocEventController);
  }

  final StreamController<AuthEvent> _inputController =
      StreamController<AuthEvent>();

  final StreamController<AuthState> _outputController =
      StreamController<AuthState>();

  Sink<AuthEvent> get input => _inputController.sink;
  Stream<AuthState> get stream => _outputController.stream;

  void _blocEventController(AuthEvent event) {
    if (event is AuthSignInEvent) {
      _outputController.add(LoadingAuthState());
      authSignIn(event.usuario).then((value) => value.fold((l) {
            _outputController.add(ErrorAuthState(msg: l.msg));
          }, (r) {
            _outputController.add(SuccessAuthState(userCredential: r));
          }));
    } else if (event is AuthSignUpEvent) {
      _outputController.add(LoadingAuthState());
      authSignUp(event.usuario).then((value) => value.fold((l) {
        _outputController.add(ErrorAuthState(msg: l.msg));
      }, (r) {
            _outputController.add(SuccessAuthState(userCredential: r));
          }));
    }
  }
}
