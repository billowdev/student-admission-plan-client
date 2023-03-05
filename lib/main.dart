import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/pages/authentication/login.dart';
import 'package:project/pages/course/all_course_page.dart';
import 'package:project/pages/main_menu/mainmenu.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const StudentAdmssionPlanAppication());
}

// Future<void> main() async {
//   await dotenv.load(fileName: '.env');
//   runApp(const StudentAdmssionPlanAppication());
// }

class StudentAdmssionPlanAppication extends StatelessWidget {
  const StudentAdmssionPlanAppication({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MainMenu(),
      //
      title: "SAPMS",
      initialRoute: '/',
      routes: {
        // ignore: prefer_const_constructors
        '/': (context) => MainMenu(), // The login page route
        // ignore: prefer_const_constructors
        '/home': (context) => MainMenu(), // The home page route
        '/all-course': (context) => AllCoursePage(), // The home page route
        '/login': (context) => LoginPage(), // The home page route
      },
    );
  }
}
