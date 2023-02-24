import 'package:flutter/material.dart';
import 'package:project/pages/main_menu/widgets/appbar.dart';
import 'package:project/pages/main_menu/widgets/navbar.dart';

class CourseInformation extends StatefulWidget {
  const CourseInformation({super.key});

  @override
  State<CourseInformation> createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
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
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                  text: const TextSpan(
                text: 'ข้อมูลหลักสูตร',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: 'PrintAble4U',
                    fontWeight: FontWeight.bold),
              )),
            ),          
          ],
        ),
      ),
    );
  }
}
