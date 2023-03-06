import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/admission_plan/faculty/admission_plan_faculty_ui.dart';
import 'package:project/ui/course/all_course_ui.dart';
import 'package:project/ui/course/course_detail_ui.dart';
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
      appBar: const AppBarWidget(txtTitle: 'แผนการรับนักศึกษาภาคปกติ'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Column(children: [
          FacultyWidget(
              facultyName: 'คณะวิทยาศาสตร์และเทคโนโลยี',
              logoPath: 'assets/images/logo_sci.jpg',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะวิทยาศาสตร์และเทคโนโลยี',
              )),
          FacultyWidget(
              facultyName: 'คณะมนุษยศาสตร์และสังคมศาสตร์',
              logoPath: 'assets/images/logo_lumanities.png',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะมนุษยศาสตร์และสังคมศาสตร์',
              )),
          FacultyWidget(
              facultyName: 'คณะเทคโนโลยีอุตสาหกรรม',
              logoPath: 'assets/images/logo_industrial.png',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะเทคโนโลยีอุตสาหกรรม',
              )),
          FacultyWidget(
              facultyName: 'คณะครุศาสตร์',
              logoPath: 'assets/images/logo_edu.png',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะครุศาสตร์',
              )),
          const FacultyWidget(
              facultyName: 'คณะเทคโนโลยีเกษตร ',
              logoPath: 'assets/images/logo_iacuc.jpg',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะเทคโนโลยีเกษตร ',
              )),
          const FacultyWidget(
              facultyName: 'คณะวิทยาการจัดการ ',
              logoPath: 'assets/images/logo_fms.jpg',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะวิทยาการจัดการ ',
              )),
        ]),
      ),
      drawer: DrawerMenuWidget(),
    ));
  }
}

PreferredSizeWidget _appBarWideget() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Image.asset(
      'assets/images/Logo.png',
      fit: BoxFit.contain,
      // width: 50,
      // height: 50,
    ),
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

class FacultyWidget extends StatelessWidget {
  final String facultyName;
  final String logoPath;
  final StatefulWidget routeScreen;
  const FacultyWidget(
      {super.key,
      required this.facultyName,
      required this.logoPath,
      required this.routeScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: ListTile(
          leading: Image.asset(
            logoPath,
            height: 80,
            width: 80,
          ),
          title: Text(
            facultyName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => routeScreen),
            );
          },
        ),
      ),
    );
  }
}
