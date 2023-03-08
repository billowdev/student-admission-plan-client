import 'package:flutter/material.dart';
import 'package:project/ui/admission_plan/menu_admission_plan_ui.dart';

import 'package:project/ui/course/all_course_ui.dart';
import 'package:project/ui/main_menu/main_menu_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/auth/login_ui.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DrawerMenuWidgetState createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  String token = "";
  String nameUser = "";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> _getNameUserFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name-user');
  }

  @override
  void initState() {
    super.initState();
    _getToken().then((value) => setState(() {
          token = value ?? "";
        }));
    _getNameUserFromToken().then((value) => setState(() {
          nameUser = value ?? "";
        }));
  }

  // void _onItemTap(int index) {
  //   setState(() {});
  // }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('name-user');
    await prefs.remove('role');
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('ออกจากระบบเรียบร้อย'),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: const EdgeInsets.all(8.0), children: <Widget>[
      DrawerHeader(
        child: token.isEmpty
            ? const Text('ยังไม่ได้เข้าสู่ระบบ')
            : Text('สวัสดีคุณ$nameUser'),
      ),
      const DrawerListTileButton(textPage: 'หน้าหลัก', routeScreen: MainMenu()),
      const DrawerListTileButton(
          textPage: 'ข้อมูลหลักสูตรทั้งหมด', routeScreen: AllCourseScreen()),
      // const DrawerListTileButton(
      //     textPage: 'ข้อมูลหลักสูตรทั้งหมด', routeScreen: AllCourseScreen()),

      const DrawerListTileButton(
          textPage: 'ข้อมูลแผนการรับนักศึกษาคณะต่าง ๆ',
          routeScreen: AdmissionPlanMenuScreen()),
// Show Logout button if token is not empty

      if (token.isNotEmpty)
        ListTile(
          title: const Text('ออกจากระบบ'),
          onTap: () async {
            _logout();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
        ),

      if (token.isEmpty)
        DrawerListTileButton(
            textPage: 'เข้าสู่ระบบ',
            routeScreen: const MainMenu(),
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            }),
    ]));
  }
}

class DrawerListTileButton extends StatelessWidget {
  final String textPage;

  final StatefulWidget routeScreen; // new parameter for button text
  final VoidCallback? onTap;

  const DrawerListTileButton({
    super.key,
    required this.textPage,
    required this.routeScreen,
    this.onTap,
  });

  // set _selectedIndex(int selectedIndex) {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(textPage),
      selectedTileColor: Colors.green[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Set rounded corners
        side: const BorderSide(color: Colors.green, width: 0.1),
      ),
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => routeScreen));
        }
      },
    );
  }
}
