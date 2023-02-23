import 'package:flutter/material.dart';

class ReceivingPlanQuotaButtonWidget extends StatelessWidget {
  const ReceivingPlanQuotaButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          'แผนการรับนักศึกษา\nประเภทโควต้า',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
