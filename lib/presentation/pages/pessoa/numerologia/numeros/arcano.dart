class Arcano {
  static Map obterArcano({required String data, required String nome}) {
    int qtdArcanos = nome.length - 1;
    String cicloArcano = (90 / qtdArcanos).toStringAsFixed(3);
    double soma = 0;
    List<Map<double, int>> tabelaArcanos = [];
    
    String numeros = converteNome(nome: nome);

    for (int index = 0; index < numeros.length - 1; index++) {
      soma += double.parse(cicloArcano);
      int arcano = int.parse(numeros.substring(index, index + 2));
      tabelaArcanos.add({double.parse(soma.toStringAsFixed(3)): arcano});
    }

    double idade = double.parse(calcularIdade(data).toStringAsFixed(3));

    List arcano = encontrarArcano(idade, tabelaArcanos);

    Map<String, int> idadeConvertida =
        converterAnosParaAnosMesesDias(arcano[1], cicloArcano, "inicio");

    String inicioArcano = dataFormatada(somarIdade(data, idadeConvertida));
    idadeConvertida =
        converterAnosParaAnosMesesDias(arcano[1], cicloArcano, "final");

    String finalArcano = dataFormatada(somarIdade(data, idadeConvertida));
    
    return {"arcano": arcano, "inicio": inicioArcano, "final": finalArcano};
  }
}

Map<String, int> converterAnosParaAnosMesesDias(
    double idade, String ciclo, String periodo) {
  if (periodo == "inicio") {
    idade -= double.parse(ciclo);
  }

  int anos = idade.floor(); // Parte inteira do ciclo representa anos
  double mesesDouble = (idade - anos) * 12; // Parte decimal convertida em meses
  int meses = mesesDouble.floor(); // Parte inteira dos meses
  double diasDouble =
      (mesesDouble - meses) * 30.44; // Parte decimal convertida em dias
  int dias = diasDouble.round(); // Arredondamos para o número inteiro de dias

  // Correção caso haja arredondamento que ultrapasse 30 dias
  if (dias >= 30) {
    meses += 1;
    dias = 0;
  }

  // Caso especial: se meses ultrapassar 11, ajustar anos e meses
  if (meses >= 12) {
    anos += 1;
    meses -= 12;
  }

  // Criar e retornar o mapa com os valores calculados
  return {
    'anos': anos,
    'meses': meses,
    'dias': dias,
  };
}

String somarIdade(String nascimento, Map<String, int> idadeConvertida) {
  // Extrair ano, mês e dia do nascimento da string
  int anoNascimento = int.parse(nascimento.substring(4, 8));
  int mesNascimento = int.parse(nascimento.substring(2, 4));
  int diaNascimento = int.parse(nascimento.substring(0, 2));

  // Somar os anos, meses e dias
  int novoAno = anoNascimento + idadeConvertida['anos']!;
  int novoMes = mesNascimento + idadeConvertida['meses']!;
  int novoDia = diaNascimento + idadeConvertida['dias']!;

  // Ajustar os meses e anos se o dia passar de 31
  if (novoDia > 31) {
    novoMes += 1;
    novoDia -= 31;
  }

  // Ajustar os meses se passar de 12
  if (novoMes > 12) {
    novoAno += 1;
    novoMes -= 12;
  }

  // Formatar os resultados com dois dígitos (padrão de datas)
  String novoAnoStr = novoAno.toString().padLeft(4, '0');
  String novoMesStr = novoMes.toString().padLeft(2, '0');
  String novoDiaStr = novoDia.toString().padLeft(2, '0');

  // Retornar a nova data no formato desejado
  return '$novoDiaStr$novoMesStr$novoAnoStr';
}

List encontrarArcano(double idade, List<Map<double, int>> tabelaArcanos) {
  double limiteAnterior = 0;
  int arcanoAnterior = -1;

  for (var mapa in tabelaArcanos) {
    for (var entrada in mapa.entries) {
      double limite = entrada.key;
      int arcano = entrada.value;

      // Se a idade é menor ou igual ao limite atual, retorna o arcano atual
      if (idade <= limite) {
        return [arcano, limite];
      }

      // Atualiza o limite anterior e o arcano anterior para a próxima iteração
      limiteAnterior = limite;
      arcanoAnterior = arcano;
    }
  }

  // Se a idade é maior que todos os limites fornecidos, retorna o último arcano
  return [arcanoAnterior, limiteAnterior];
}

double calcularIdade(String dataNascimento) {
  // Extrair dia, mês e ano da string de entrada
  int dia = int.parse(dataNascimento.substring(0, 2));
  int mes = int.parse(dataNascimento.substring(2, 4));
  int ano = int.parse(dataNascimento.substring(4));

  // Criar um objeto DateTime representando a data de nascimento
  DateTime dataNasc = DateTime(ano, mes, dia);

  // Obter a data atual
  DateTime dataAtual = DateTime.now();

  // Calcular a diferença em anos
  int anos = dataAtual.year - dataNasc.year;

  // Ajustar os anos se o mês atual for menor que o mês de nascimento ou se estivermos no mesmo mês mas o dia atual for menor que o dia de nascimento
  if (dataAtual.month < dataNasc.month ||
      (dataAtual.month == dataNasc.month && dataAtual.day < dataNasc.day)) {
    anos--;
  }

  // Calcular a diferença em meses
  int meses = dataAtual.month - dataNasc.month;
  if (meses < 0 || (meses == 0 && dataAtual.day < dataNasc.day)) {
    meses += 12;
  }

  // Calcular a diferença em dias
  double dias = (dataAtual.day - dataNasc.day).toDouble();
  if (dias < 0) {
    dias += DateTime(dataAtual.year, dataAtual.month - 1, 0).day;
  }

  // Converter anos, meses e dias para o formato desejado
  double idadeEmAnos = anos + (meses / 12) + (dias / 365);

  return idadeEmAnos;
}

String converteNome({required String nome}) {
  String resultado = "";
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

  for (int index = 0; index < nome.length; index++) {
    resultado += (tabela[nome[index]]).toString();
  }

  return resultado;
}

String dataFormatada(String data) {
  String dia = data.substring(0, 2);
  String mes = data.substring(2, 4);
  String ano = data.substring(4);

  String dataFormatada = '$dia/$mes/$ano';

  return dataFormatada;
}
