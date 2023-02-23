import 'package:flutter/material.dart';

class FacultyInformationButtonWidget extends StatelessWidget {
  const FacultyInformationButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'ข้อมูลคณะ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
