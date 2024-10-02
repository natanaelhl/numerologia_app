class TranslatorErrors {
  static build(String message) {
    if (message ==
        '[firebase_auth/channel-error] "dev.flutter.pigeon.firebase_auth_platform_interface.FirebaseAuthHostApi.signInWithEmailAndPassword".') {
      return "Dados inseridos inválidos...!";
    } else if (message ==
        '[firebase_auth/channel-error] "dev.flutter.pigeon.firebase_auth_platform_interface.FirebaseAuthHostApi.createUserWithEmailAndPassword".') {
          return "Dados inseridos inválidos...!";
    } else if (message ==
        '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.') {
      return "E-mail ou senha inválido...!";
    } else if (message == '[firebase_auth/weak-password] Password should be at least 6 characters'){
      return "A senha precisa ter no mínimo 6 caracteres!";
    } else if (message == '[firebase_auth/invalid-email] The email address is badly formatted.') {
      return "Formato de E-mail inválido!";
    }
  }
}
