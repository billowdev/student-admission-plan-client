import 'package:flutter/material.dart';
import 'package:project/pages/main_menu/course_information.dart';

class CourseInformationButtonWidget extends StatelessWidget {
  const CourseInformationButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(color: Colors.green, width: 1)),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourseInformation()));
        },
        child: const Text(
          'ข้อมูลหลักสูตร',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
