import 'package:flutter/material.dart';

class InformationButtonWidget extends StatelessWidget {
  final String buttonText; // new parameter for button text
  final StatefulWidget routeScreen; // new parameter for button text
  const InformationButtonWidget(
      {Key? key, required this.buttonText, required this.routeScreen})
      : super(key: key);

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
              context, MaterialPageRoute(builder: (context) => routeScreen));
        },
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
