import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/course/all_course_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/infomation_button_widget.dart';

class AdmissionPlanMenuScreen extends StatefulWidget {
  const AdmissionPlanMenuScreen({super.key});

  @override
  State<AdmissionPlanMenuScreen> createState() =>
      _AdmissionPlanMenuScreenState();
}

class _AdmissionPlanMenuScreenState extends State<AdmissionPlanMenuScreen> {
  late String role = "";

  Future<String?> _getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  @override
  void initState() {
    super.initState();
    _getRole().then((value) => setState(() {
          role = value ?? 'user';
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'ระบบแผนการรับนักศึกษา'),
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
                      buttonText: 'ข้อมูลหลักสูตรทั้งหมด',
                      routeScreen: AllCourseScreen(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const DrawerMenuWidget(),
    ));
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
