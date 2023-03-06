import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/admission_plan/admission_plan_menu_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/infomation_button_widget.dart';
import '../course/all_course_ui.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late String role = "";
  late String _latestYear = "2566";

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
      appBar: AppBarWidget(txtTitle: 'ระบบจัดการแผนการรับนักศึกษา'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: <Widget>[
            MainMenuWidget(
              menuName: 'ข้อมูลหลักสูตรทั้งหมด',
              routeScreen: const AllCourseScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'แผนการรับนักศึกษาภาคปกติ',
              routeScreen: const AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'ภาคพิเศษ(กศ.ป.)',
              routeScreen: const AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'แผนการรับนักศึกษาภาคปกติ',
              routeScreen: const AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'สรุปจำนวนทุกรอบภาคปกติ',
              routeScreen: const AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'รอบโควตาปีการศึกษา $_latestYear',
              routeScreen: const AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'ผู้รับผิดชอบโควตา',
              routeScreen: const AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'สรุปจำนวนทุกรอบภาคปกติ',
              routeScreen: const AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            )
          ],
        ),
      ),
      drawer: DrawerMenuWidget(),
    ));
  }
}

class MainMenuWidget extends StatelessWidget {
  final String menuName;
  final StatefulWidget routeScreen;
  final Icon leadingIcon;
  const MainMenuWidget(
      {super.key,
      required this.menuName,
      required this.routeScreen,
      required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: ListTile(
          leading: leadingIcon,
          title: Text(
            menuName,
            // ignore: prefer_const_constructors
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
