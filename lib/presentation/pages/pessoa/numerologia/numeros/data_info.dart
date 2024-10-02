class DataInfo {
  static numbers(String value) {
    String numbers = '';

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

    for (int index = 0; index < value.length; index++) {
      value[index] == " "
          ? numbers += " "
          : numbers += tabela[value[index].toUpperCase()].toString();
    }
    return numbers;
  }

  static formatName(String value){
    print(value.replaceAll(RegExp(r'\s+'), '').toUpperCase());
    return value.replaceAll(RegExp(r'\s+'), '').toUpperCase();
    
  }
}
