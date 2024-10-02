import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  void Function()? drawerOpen;
  bool isbackbutton;
  @override
  Size get preferredSize => const Size.fromHeight(140);
  CustomAppBarWidget(
      {super.key, required this.isbackbutton, this.drawerOpen});
  
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 140,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorPallete.primaryColor, ColorPallete.primaryEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isbackbutton) _backButtonWidget(context),
            const SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 20.0,
                    
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${currentUser!.displayName}",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${currentUser.email}",
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Widget _backButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorPallete.primaryEnd),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 10,
                  color: ColorPallete.yellowColor,
                ),
                const Text(
                  "Voltar",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          )),
    );
  }
}
