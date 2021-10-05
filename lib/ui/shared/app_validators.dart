class AppValidators {
  static String? validarEmail(String input) {
    if (input.isEmpty) {
      return "Digite o Login";
    }
  }

  static String? validarSenha(String input) {
    if (input.isEmpty || input.length < 6) {
      return "Digite a Senha com no minimo 6 digitos";
    }
  }

  static String? validarConfirmaSenha(String firstInput, String secondInput) {
    if (firstInput != secondInput) return 'Senhas não conferem';
  }

  static String? validaNome(String input) {
    if (input.isEmpty) {
      return "Digite seu nome";
    }
  }
}
