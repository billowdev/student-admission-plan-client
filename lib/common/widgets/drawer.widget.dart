import 'package:flutter/material.dart';
import 'package:project/pages/authentication/login.dart';
import 'package:project/pages/course/all_course_page.dart';
import 'package:project/pages/course/course_detail_page.dart';
import 'package:project/pages/main_menu/home.dart';
import 'package:project/pages/main_menu/mainmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({super.key});

  @override
  _DrawerMenuWidgetState createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  int _selectedIndex = 0;
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
          nameUser = value.toString();
        }));
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('name-user');
    await prefs.remove('role');
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
      DrawerListTileButton(textPage: 'หน้าหลัก', routeScreen: MainMenu()),
      DrawerListTileButton(
          textPage: 'คุณสมบัตินักศึกษาตามหลักสูตร', routeScreen: HomePage()),
      DrawerListTileButton(
          textPage: 'แผนการรับนักศึกษา', routeScreen: AllCoursePage()),
// Show Logout button if token is not empty

      if (token != "")
        DrawerListTileButton(
            textPage: 'ออกจากระบบ',
            routeScreen: MainMenu(),
            onTap: () async {
              _logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }),
      if (token == "")
        DrawerListTileButton(
            textPage: 'เข้าสู่ระบบ',
            routeScreen: MainMenu(),
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/login', (Route<dynamic> route) => false);
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

  set _selectedIndex(int _selectedIndex) {}

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
