import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function onYes;
  final Function onNo;
  final Color btnColor;
  final String btnText;

  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onYes,
    required this.onNo,
    required this.btnColor,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: btnColor,
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                onNo(), // Call the onNo callback
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(),
                onYes(), // Call the onYes callback
              },
              child: const Text('ยืนยัน'),
            ),
          ],
        ),
      ),
      child: Text(btnText),
    );
  }
}
