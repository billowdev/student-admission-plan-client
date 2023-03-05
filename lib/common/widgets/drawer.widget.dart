import 'package:flutter/material.dart';
import 'package:project/pages/course/course_page.dart';
import 'package:project/pages/main_menu/home.dart';
import 'package:project/pages/main_menu/mainmenu.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({super.key});

  @override
  _DrawerMenuWidgetState createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: const EdgeInsets.all(8.0), children: <Widget>[
      const DrawerHeader(
        child: Text('เมนู'),
      ),
      DrawerListTileButton(textPage: 'หน้าหลัก', RouteScreen: MainMenu()),
      DrawerListTileButton(
          textPage: 'คุณสมบัตินักศึกษาตามหลักสูตร', RouteScreen: HomePage()),
      DrawerListTileButton(
          textPage: 'แผนการรับนักศึกษา', RouteScreen: CoursePage()),
      DrawerListTileButton(
        textPage: 'คุณสมบัตินักศึกษาตามหลักสูตร',
        RouteScreen: CoursePage(),
      ),
      // DrawerListTileButton(
      //   textPage: 'แผนการรับนักศึกษาประเภทโควตา',
      //   RouteScreen: MajorInformation(),
      // ),
      // DrawerListTileButton(
      //   textPage: 'ข้อมูลหลักสตร',
      //   RouteScreen: MajorInformation(),
      // ),
      // DrawerListTileButton(
      //   textPage: 'ข้อมูลคณะ',
      //   RouteScreen: MajorInformation(),
      // ),
      ListTile(
        title: const Text('ข้อมูลคณะ'),
        selected: _selectedIndex == 4,
        selectedTileColor: Colors.green[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          side: const BorderSide(color: Colors.green, width: 0.1),
        ),
        onTap: () {
          _onItemTap(4);
        },
      ),
      ListTile(
        title: const Text('ข้อมูลสาขา'),
        selected: _selectedIndex == 5,
        selectedTileColor: Colors.green[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Set rounded corners
            side: const BorderSide(color: Colors.green, width: 0.1)),
        onTap: () {
          Navigator.pop(context,
              MaterialPageRoute(builder: (context) => const CoursePage()));
          _onItemTap(5);
        },
      )
    ]));
  }
}

class DrawerListTileButton extends StatelessWidget {
  final String textPage;

  final StatefulWidget RouteScreen; // new parameter for button text
  // final bool? selectedIndexBool;
  // final int? onTapIndex;
  const DrawerListTileButton({
    super.key,
    required this.textPage,
    required this.RouteScreen,
    // required this.selectedIndexBool,
    // required this.onTapIndex
  });

  set _selectedIndex(int _selectedIndex) {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(textPage),
      // selected: selectedIndexBool,
      selectedTileColor: Colors.green[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Set rounded corners
        side: const BorderSide(color: Colors.green, width: 0.1),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RouteScreen));

        // this._selectedIndex = onTapIndex;
      },
    );
  }
}

class Number {}
