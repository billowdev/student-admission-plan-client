import 'package:flutter/material.dart';
import 'package:project/pages/authentication/login.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
      title: const Text(
        'มหาวิทยาลัยราชภัฏสกลนคร',
        style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'PrintAble4U',
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: const BorderSide(color: Colors.green, width: 1)),
          ),
          child: const Text('Login', style: TextStyle(color: Colors.green)),
        )
      ],
    ));
  }
}
