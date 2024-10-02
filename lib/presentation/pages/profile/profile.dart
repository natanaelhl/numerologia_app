import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';
import 'package:ricardo_peres/core/widgets/custom_app_bar_widget.dart';
import 'package:ricardo_peres/core/widgets/text_field_custom_widget.dart';
import 'package:ricardo_peres/presentation/pages/profile/styles/profile_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textTest = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.primaryColor,
      ), body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              CircleAvatar(radius: 60,)
            ],),
            const SizedBox(height: 16,),
            Text("Nome:", style: ProfileStyles.dataProfile(),),
            SizedBox(height: 8,),
            TextFieldCustomWidget(hintText: "Teste", controller: textTest),
            SizedBox(height: 16,),
            Text("Telefone:", style: ProfileStyles.dataProfile(),),
            SizedBox(height: 8,),
            TextFieldCustomWidget(hintText: "Teste", controller: textTest),
            SizedBox(height: 16,),
            Text("E-mail:", style: ProfileStyles.dataProfile(),),
            SizedBox(height: 8,),
            TextFieldCustomWidget(hintText: "Teste", controller: textTest)
          ],
        ),
      ),);
  }
}