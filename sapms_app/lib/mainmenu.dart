import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
          title: const Text('มหาวิทยาลัยราชภัฏสกลนคร',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'PrintAble4U')),
          actions: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.green, width: 1)),
                ),
                child:
                    const Text('Login', style: TextStyle(color: Colors.green)))
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                      text: const TextSpan(
                    text: 'เมนูหลัก',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: 'PrintAble4U'),
                  ))),
  
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:[Major_Information(), Student_Qualification()]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Course_Information(), Receiving_Plan_Quota()]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Faculty_Information(), Receiving_Plan()]),
              
            ])));
  }

  Widget Major_Information() {
    return ElevatedButton(onPressed: () {}, child: const Text('ข้อมูลสาขา'));
  }

  Widget Course_Information() {
    return ElevatedButton(
        onPressed: () {}, child: const Text('ข้อมูลหลักสูตร'));
  }

  Widget Faculty_Information() {
    return ElevatedButton(onPressed: () {}, child: const Text('ข้อมูลคณะ'));
  }

  Widget Student_Qualification() {
    return ElevatedButton(
        onPressed: () {}, child: const Text('คุณสมบัตินักศึกษา\nตามหลักสูตร'));
  }

  Widget Receiving_Plan_Quota() {
    return ElevatedButton(
        onPressed: () {}, child: const Text('แผนการรับนักศึกษา\nประเภทโควต้า'));
  }

  Widget Receiving_Plan() {
    return ElevatedButton(
        onPressed: () {}, child: const Text('แผนการรับนักศึกษา'));
  }
}
