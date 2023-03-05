import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/pages/course/course_page.dart';
import 'package:project/pages/main_menu/widgets/appbar.dart';

import 'widgets/infomation_button_widget.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(txtTitle: 'ระบบแผนการรับนักศึกษา'),
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
                    fontFamily: 'PrintAble4U',
                    fontWeight: FontWeight.bold),
              )),
            ),

            // Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [Major_Information(), Student_Qualification()]),
            // Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [Course_Information(), Receiving_Plan_Quota()]),
            // Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [Faculty_Information(), Receiving_Plan()]),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: const [
                    InformationButtonWidget(
                      buttonText: 'ข้อมูลสาขา',
                      RouteScreen: const CoursePage(),
                    ),

                    InformationButtonWidget(
                      buttonText: 'คุณสมบัตินักศึกษา\nตามหลักสูตร',
                      RouteScreen: const CoursePage(),
                    ),
                    InformationButtonWidget(
                      buttonText: 'ข้อมูลหลักสูตร',
                      RouteScreen: const CoursePage(),
                    ),
// ข้อมูลหลักสูตร
// ข้อมูลคณะ
// แผนการรับนักศึกษาประเภทโควตา
// แผนการรับนักศึกษาทั้งหมด
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _appBarWideget() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
    title: const Text(
      'ระบบจัดการแผนการรับนักศึกษา',
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
  );
}
