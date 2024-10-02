class NumerosSimples {

  static Map<String, int> destino({required String data}) {
    int soma = 0;
    for (int index = 0; index < data.length; index++) {
      soma += int.parse(data[index]);
    }

    Map<String, int> resultado = encurtadorNumerico(soma, true);

    return resultado;
  }

  static Map<String, int> expressao({required String nome}) {
    Map<String, int> resultado =
        tabelaConverte(nome: nome, chave: "a<z", mestre: true);

    return resultado;
  }

  static Map<String, int> impressao({required String nome}) {
    Map<String, int> resultado =
        tabelaConverte(nome: nome, chave: "consoantes", mestre: false);

    return resultado;
  }

  static Map<String, int> missao(
      {required int destino, required int expressao}) {
    Map<String, int> resultado =
        encurtadorNumerico((expressao + destino), true);

    return resultado;
  }

  static Map<String, int> motivacao(String nome) {
    Map<String, int> resultado =
        tabelaConverte(nome: nome, chave: "vogais", mestre: false);

    return resultado;
  }

  static Map<String, int> numeroPsiquico({required String data}) {
    int diaNacimento = int.parse(data.substring(0, 2));
    Map<String, int> resultado = encurtadorNumerico(diaNacimento, false);

    return resultado;
  }

  static Map<String, int> talentoOculto(
      {required int expressao, required int motivacao}) {
    Map<String, int> resultado =
        encurtadorNumerico((expressao + motivacao), true);

    return resultado;
  }

  static Map<String, int> primeiroCiclo({required String data, required int destino}) {
    int mesNascimento = int.parse(data.substring(2, 4));
    int tempoCiclo = 37 - destino;
    int inicioCiclo = int.parse(data.substring(4));
    int finalCiclo = inicioCiclo + tempoCiclo;
    Map<String, int> numeroCiclo = encurtadorNumerico((mesNascimento), true);
    
    
    Map<String, int> resultado = {"ciclo": numeroCiclo["final"]!,
     "inicio_ciclo": inicioCiclo, "final_ciclo": finalCiclo};

    return resultado;
  }

  static Map<String, int> segundoCiclo({required String data, required int finalPrimeiroCiclo}) {
    int diaNascimento = int.parse(data.substring(0,2));
    int tempoCiclo = 27;
    int inicioCiclo = finalPrimeiroCiclo;
    int finalCiclo = inicioCiclo + tempoCiclo;
    Map<String, int> numeroCiclo = encurtadorNumerico((diaNascimento), true);
    
    Map<String, int> resultado = {"ciclo": numeroCiclo["final"]!,
     "inicio_ciclo": inicioCiclo, "final_ciclo": finalCiclo};

    return resultado;
  }

  static Map<String, int> terceiroCiclo({required String data, required int finalSegundoCiclo}) {
    int anoNascimento = int.parse(data.substring(4));
    int inicioCiclo = finalSegundoCiclo;

    Map<String, int> numeroCiclo = encurtadorNumerico((anoNascimento), true);
    
    Map<String, int> resultado = {"ciclo": numeroCiclo["final"]!,
     "inicio_ciclo": inicioCiclo,};

    return resultado;
  }
}

// Converte as letras para o resultado numerológico
Map<String, int> tabelaConverte(
    {required String nome, required String chave, required bool mestre}) {
  late String letrasNumerologicas;
  int soma = 0;
  Map<String, int> resultado;

  Map<String, int> tabela = {
    "A": 1,
    "À": 2,
    "Á": 3,
    "Â": 8,
    "Ã": 4,
    "Ä": 2,
    "B": 2,
    "C": 3,
    "Ç": 6,
    "D": 4,
    "E": 5,
    "È": 1,
    "É": 7,
    "Ê": 3,
    "Ë": 1,
    "F": 8,
    "G": 3,
    "H": 5,
    "I": 1,
    "Ì": 2,
    "Í": 3,
    "Î": 8,
    "Ï": 2,
    "J": 1,
    "K": 2,
    "L": 3,
    "M": 4,
    "N": 5,
    "Ñ": 8,
    "O": 7,
    "Ò": 5,
    "Ó": 9,
    "Ô": 5,
    "Õ": 1,
    "Ö": 5,
    "P": 8,
    "Q": 1,
    "R": 2,
    "S": 3,
    "T": 4,
    "U": 6,
    "Ù": 3,
    "Ú": 8,
    "Û": 4,
    "Ü": 3,
    "V": 6,
    "W": 6,
    "X": 6,
    "Y": 1,
    "Ý": 3,
    "Z": 7,
  };

  switch (chave) {
    case "vogais":
      letrasNumerologicas = "AÀÁÂÃÄEÉÈÊËIÍÌÎÏOÓÒÔÖUÚÙÛÜY";
      break;
    case "consoantes":
      letrasNumerologicas = "BCÇDFGHJKLMNPQRSTVWXYÝZ";
      break;
    case "a<z":
      letrasNumerologicas = "AÀÁÂÃÄEÉÈÊËIÍÌÎÏOÓÒÔÖUÚÙÛÜYBCÇDFGHJKLMNPQRSTVWXYÝZ";
      break;
  }

  for (int index = 0; index < nome.length; index++) {
    if (letrasNumerologicas.contains(nome[index])) {
      soma += tabela[nome[index]]!;
    }
  }

  resultado = encurtadorNumerico(soma, mestre);

  return resultado;
}

Map<String, int> encurtadorNumerico(int soma, bool mestre) {
  Map<String, int> resultado = {};
 
  if (mestre) {
    switch (soma) {
      case 22 || 11:
        resultado = {"grupo": soma, "final": soma};
        return resultado;
      default:
        int preSoma = soma;
        
        // Obter os dígitos da dezena
        int dezena =
            soma ~/ 10; // Divisão inteira por 10 para obter o primeiro dígito
        int unidade = soma % 10; // Módulo por 10 para obter o segundo dígito

        // Calcular a soma dos dígitos
        soma = dezena + unidade;
        
        if (soma == 11 || soma == 22) {
          resultado = {"grupo": preSoma, "final": soma};
          return resultado;
        }

        while (soma >= 10) {
          soma = soma ~/ 10 + soma % 10;
        }

        resultado = {"grupo": preSoma, "final": soma};
        return resultado;
    }
  }

  int preSoma = soma;

  // Obter os dígitos da dezena
  int dezena =
      soma ~/ 10; // Divisão inteira por 10 para obter o primeiro dígito
  int unidade = soma % 10; // Módulo por 10 para obter o segundo dígito

  // Calcular a soma dos dígitos
  soma = dezena + unidade;

  // Se a soma tiver mais de um dígito, reduzir novamente
  while (soma >= 10) {
    soma = soma ~/ 10 + soma % 10;
  }

  resultado = {"grupo": preSoma, "final": soma};

  return resultado;
}
