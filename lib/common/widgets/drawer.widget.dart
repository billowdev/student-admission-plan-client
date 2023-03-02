import 'package:flutter/material.dart';
import 'package:project/pages/course/course_page.dart';
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
      DrawerListTileButton(textPage: 'คุณสมบัตินักศึกษาตามหลักสูตร'),
      DrawerListTileButton(textPage: 'แผนการรับนักศึกษา'),
      DrawerListTileButton(textPage: 'คุณสมบัตินักศึกษาตามหลักสูตร'),
      DrawerListTileButton(textPage: 'แผนการรับนักศึกษาประเภทโควตา'),
      DrawerListTileButton(textPage: 'ข้อมูลหลักสตร'),
      DrawerListTileButton(textPage: 'ข้อมูลคณะ'),
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

class DrawerListTileButton extends StatelessWidget {
  final String textPage;
  // final bool? selectedIndexBool;
  // final int? onTapIndex;
  const DrawerListTileButton({
    super.key,
    required this.textPage,
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
        // this._selectedIndex = onTapIndex;
      },
    );
  }
}

class Number {}
