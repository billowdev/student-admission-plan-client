import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/admission_plan/menu_admission_plan_ui.dart';
import 'package:project/ui/auth/login_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/infomation_button_widget.dart';
import '../course/all_course_ui.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late String role = "";
  late final String _latestYear = "2566";

  Future<String?> _getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  late String token = "";
  @override
  void initState() {
    super.initState();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));

    _getRole().then((value) => setState(() {
          role = value ?? 'user';
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'ระบบจัดการแผนการรับนักศึกษา'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: <Widget>[
            const MainMenuWidget(
              menuName: 'ข้อมูลหลักสูตรทั้งหมด',
              routeScreen: AllCourseScreen(),
              leadingIcon: Icon(Icons.edit_document),
            ),
            const MainMenuWidget(
              menuName: 'แผนการรับนักศึกษาภาคปกติ',
              routeScreen: AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            const MainMenuWidget(
              menuName: 'ภาคพิเศษ(กศ.ป.)',
              routeScreen: AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'รอบโควตาปีการศึกษา $_latestYear',
              routeScreen: const AdmissionPlanMenuScreen(),
              leadingIcon: const Icon(Icons.bookmark),
            ),
            const MainMenuWidget(
              menuName: 'ผู้รับผิดชอบโควตา',
              routeScreen: AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.supervisor_account),
            ),
            const MainMenuWidget(
              menuName: 'สรุปจำนวนทุกรอบภาคปกติ',
              routeScreen: AdmissionPlanMenuScreen(),
              leadingIcon: Icon(Icons.summarize),
            ),
          ],
        ),
      ),
      drawer: const DrawerMenuWidget(),
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
