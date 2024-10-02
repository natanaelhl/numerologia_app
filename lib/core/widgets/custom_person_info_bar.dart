import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';
import 'package:ricardo_peres/domain/entities/pessoa.dart';
import 'package:ricardo_peres/presentation/pages/pessoa/numerologia/numeros/data_info.dart';

class CustomPersonInfoBar extends StatelessWidget {
  final Pessoa pessoa;
  const CustomPersonInfoBar({super.key, required this.pessoa});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPallete.primaryColor,
            borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _caracteresEditString(DataInfo.numbers(pessoa.nome!), true),
                      const SizedBox(
                        height: 6,
                      ),
                      _caracteresEditString(pessoa.nome!, false),
                      const SizedBox(
                        height: 6,
                      ),
                      _editPersonButton(Icons.edit, "Editar Paciente")
                    ],
                  ),
                ),
              
              ],
            ),
          )),
    );
  }

  Widget _caracteresEditString(String value, bool isNumber) {
    List<Widget> listCaracteres = [];
    for (var caractere in value.characters) {
      listCaracteres.add(
        SizedBox(
          width: 12,
          child: Text(
            caractere,
            style: TextStyle(
              color: isNumber ? ColorPallete.greyColor : Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: isNumber ? 12 : 14,
              fontWeight: isNumber ? FontWeight.normal : FontWeight.bold,
               // Espaçamento entre os caracteres
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    Row result = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: listCaracteres,
    );
    return result;
  }

  Widget _editPersonButton(IconData icon, String label) {
    return Container(
      width: 120,
      height: 28,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _pyramidInfoButton() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ColorPallete.primaryEnd,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ImageIcon(
            const AssetImage('assets/images/adicionar-usuario.png'),
            size: 24,
            color: ColorPallete.yellowColor
          ),
          const SizedBox(width: 4),
          Text(
            "Abrir",
            style: TextStyle(fontSize: 12, color: ColorPallete.greyColor, fontStyle: FontStyle.italic),
          ),
          Text(
            "Pirâmide",
            style: TextStyle(fontSize: 12, color: ColorPallete.greyColor, fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
