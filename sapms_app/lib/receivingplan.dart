import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
          title: const Text('มหาวิทยาลัยราชภัฏสกลนคร',
              style: TextStyle(color: Colors.black, fontSize: 25,fontFamily: 'PrintAble4U')),
          actions: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.green, width: 1)),
                ),
                child: const Text('Login', style: TextStyle(color: Colors.green)))
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                text: const TextSpan(
                  text: 'แผนการรับนักศึกษา ',
                  style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: 'PrintAble4U'),
                  children: [
                    TextSpan(
                      text: '\nมหาวิทยาลัยราชภัฏสกลนคร',
                      style: TextStyle(fontSize: 23, color: Colors.black, fontFamily: 'PrintAble4U'),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
