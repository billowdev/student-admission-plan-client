import 'package:flutter/material.dart';

class StudentQualificationButtonWidget extends StatelessWidget {
  const StudentQualificationButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'คุณสมบัตินักศึกษา\nตามหลักสูตร',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
