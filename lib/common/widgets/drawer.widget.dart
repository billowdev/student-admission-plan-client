import 'package:flutter/material.dart';
import 'package:project/pages/main_menu/course_information.dart';
import 'package:project/pages/main_menu/major_information.dart';

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
      ListTile(
        title: const Text('คุณสมบัตินักศึกษาตามหลักสูตร'),
        selected: _selectedIndex == 0,
        selectedTileColor: Colors.green[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          side: const BorderSide(color: Colors.green, width: 0.1),
        ),
        onTap: () {
          _onItemTap(0);
        },
      ),
      ListTile(
        title: const Text('แผนการรับนักศึกษา'),
        selected: _selectedIndex == 1,
        selectedTileColor: Colors.green[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          side: const BorderSide(color: Colors.green, width: 0.1),
        ),
        onTap: () {
          _onItemTap(1);
        },
      ),
      ListTile(
        title: const Text('แผนการรับนักศึกษาประเภทโควตา'),
        selected: _selectedIndex == 2,
        selectedTileColor: Colors.green[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          side: const BorderSide(color: Colors.green, width: 0.05),
        ),
        onTap: () {
          _onItemTap(2);
        },
      ),
      ListTile(
        title: const Text('ข้อมูลหลักสตร'),
        selected: _selectedIndex == 3,
        selectedTileColor: Colors.green[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          side: const BorderSide(color: Colors.green, width: 0.1),
        ),
        onTap: () {
          Navigator.pop(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourseInformation()));
          _onItemTap(3);
        },
      ),
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
          Navigator.pop(
              context,
              MaterialPageRoute(
                  builder: (context) => const MajorInformation()));
          _onItemTap(5);
        },
      )
    ]));
  }
}
