import 'package:flutter/material.dart';
import 'package:project/pages/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String txtTitle;

  const AppBarWidget({Key? key, required this.txtTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
      title: Text(
        txtTitle,
        style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'PrintAble4U',
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      actions: [
        // ElevatedButton(
        //     onPressed: () {},
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.white,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(50),
        //           side: const BorderSide(color: Colors.green, width: 1)),
        //     ),
        //     child: const Text('menu', style: TextStyle(color: Colors.green)))
        ElevatedButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: const BorderSide(color: Colors.green, width: 1)),
          ),
          child: const Text('menu', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
