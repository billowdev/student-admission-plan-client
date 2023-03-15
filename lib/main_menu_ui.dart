import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/admission_plan/menu_admission_plan_ui.dart';
import 'package:project/ui/extra_admission_plan/menu_extra_admission_plan_ui.dart';
import 'package:project/ui/responsible_quota_person/responsible_quota_person_ui.dart';
import 'package:project/ui/user/all_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'common/constants/constants.dart';
import 'common/utils/decoded_token_util.dart';
import 'common/utils/local_storage_util.dart';
import 'ui/course/all_course_ui.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late String role = "";
  late String _decodedRole = "";
  late final String _latestYear = "2566";

  _getRole() async {
    final String role = await decodeRoleTokenUtil();
    setState(() {
      _decodedRole = role;
    });
  }

  late List<String> _yearList = ["2565", "2566"];

  _getExistsYear() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/admission-plans/get-exists-year');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      List<String> yearList = List<String>.from(resp['payload']);
      yearList.sort((a, b) => b.compareTo(a));
      setState(() {
        // _selectedYear = yearList[0];
        _yearList = yearList;
      });
    }
  }

  late String token = "";
  @override
  void initState() {
    super.initState();
    _getExistsYear();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
    _getRole();
    // _getRole().then((value) => setState(() {
    //       role = value ?? 'user';
    //     }));
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
            MainMenuWidget(
              menuName: 'ภาคปกติ',
              routeScreen: AdmissionPlanMenuScreen(
                educationYearList: _yearList,
              ),
              leadingIcon: const Icon(Icons.bookmark),
            ),
            MainMenuWidget(
              menuName: 'ภาคพิเศษ(กศ.ป.)',
              routeScreen: MenuExtraAdmissionPlanScreen(
                educationYearList: _yearList,
              ),
              leadingIcon: const Icon(Icons.bookmark),
            ),
            // MainMenuWidget(
            //   menuName: 'รอบโควตาปีการศึกษา $_latestYear',
            //   routeScreen: AdmissionPlanMenuScreen(
            //     educationYearList: _yearList,
            //   ),
            //   leadingIcon: const Icon(Icons.bookmark),
            // ),
            const MainMenuWidget(
              menuName: 'ผู้รับผิดชอบโควตา',
              routeScreen: AllResponseibleQuotaPersonScreen(),
              leadingIcon: Icon(Icons.supervisor_account),
            ),
            MainMenuWidget(
              menuName: 'สรุปจำนวนทุกรอบภาคปกติ',
              routeScreen: AdmissionPlanMenuScreen(
                educationYearList: _yearList,
              ),
              leadingIcon: const Icon(Icons.summarize),
            ),

            Visibility(
                visible: _decodedRole == "admin",
                child: const SizedBox(
                  child: MainMenuWidget(
                    menuName: 'จัดการข้อมูลบัญชีผู้ใช้',
                    routeScreen: AllUserScreen(),
                    leadingIcon: Icon(Icons.summarize),
                  ),
                )),
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
