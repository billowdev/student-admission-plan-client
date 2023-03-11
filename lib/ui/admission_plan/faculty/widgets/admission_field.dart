import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdmissionInputFields extends StatefulWidget {
  final String specificSubject;
  final int qty;
  final String detail;
  final bool status;
  final Function(bool) onStatusChanged;
  final Function(String) onSpecificSubjectChanged;
  final Function(int) onQtyChanged;
  final Function(String) onDetailChanged;

  AdmissionInputFields({
    required this.specificSubject,
    required this.qty,
    required this.detail,
    required this.status,
    required this.onStatusChanged,
    required this.onSpecificSubjectChanged,
    required this.onQtyChanged,
    required this.onDetailChanged,
  });

  @override
  _AdmissionInputFieldsState createState() => _AdmissionInputFieldsState();
}

class _AdmissionInputFieldsState extends State<AdmissionInputFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Table(
            children: [
              TableRow(
                children: [
                  const TableCell(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Text(
                        "สถานะ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Switch(
                      value: widget.status,
                      onChanged: widget.onStatusChanged,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.status,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'วิชาเฉพาะ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.specificSubject,
                onChanged: widget.onSpecificSubjectChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    widget.onSpecificSubjectChanged("-");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'จำนวนที่รับ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.qty.toString(),
                onChanged: (value) {
                  widget.onQtyChanged(int.tryParse(value) ?? 0);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกจำนวนที่รับ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'รายละเอียด',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.detail,
                onChanged: widget.onDetailChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรายละเอียด';
                  }
                  return null;
                },
                maxLines: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
