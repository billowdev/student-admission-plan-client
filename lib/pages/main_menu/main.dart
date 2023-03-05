import 'package:flutter/material.dart';
import 'package:project/pages/main_menu/mainmenu.dart';

void main() {
  runApp(const StudentAdmssionPlanAppication());
}

class StudentAdmssionPlanAppication extends StatelessWidget {
  const StudentAdmssionPlanAppication({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainMenu());
  }
}