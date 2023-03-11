import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuotaAdmissionInputFields extends StatefulWidget {
  final String specificSubject;
  final int quotaGoodStudyQty;
  final int quotaGoodPersonQty;
  final int quotaGoodActivityIMQty;
  final int quotaGoodActivityLIQty;
  final int quotaGoodActivitySDDQty;
  final int quotaGoodSportQty;
  final String detail;
  final bool status;
  final Function(bool) onStatusChanged;
  final Function(String) onSpecificSubjectChanged;
  final Function(int) onQuotaGoodStudyQtyChanged;
  final Function(int) onQuotaGoodPersonQtyChanged;
  final Function(int) onQuotaGoodActivityIMQtyChanged;
  final Function(int) onQuotaGoodActivityLIQtyChanged;
  final Function(int) onQuotaGoodActivitySDDQtyChanged;
  final Function(int) onQuotaGoodSportQtyChanged;

  final Function(String) onDetailChanged;

  QuotaAdmissionInputFields({
    required this.specificSubject,
    required this.quotaGoodStudyQty,
    required this.quotaGoodPersonQty,
    required this.quotaGoodActivityIMQty,
    required this.quotaGoodActivityLIQty,
    required this.quotaGoodActivitySDDQty,
    required this.quotaGoodSportQty,
    required this.detail,
    required this.status,
    required this.onStatusChanged,
    required this.onSpecificSubjectChanged,
    required this.onQuotaGoodStudyQtyChanged,
    required this.onQuotaGoodPersonQtyChanged,
    required this.onQuotaGoodActivityIMQtyChanged,
    required this.onQuotaGoodActivityLIQtyChanged,
    required this.onQuotaGoodActivitySDDQtyChanged,
    required this.onQuotaGoodSportQtyChanged,
    required this.onDetailChanged,
  });

  @override
  _QuotaAdmissionInputFieldsState createState() =>
      _QuotaAdmissionInputFieldsState();
}

class _QuotaAdmissionInputFieldsState extends State<QuotaAdmissionInputFields> {
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
                'จำนวนที่รับ ประเภทเรียนดี',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.quotaGoodStudyQty.toString(),
                onChanged: (value) {
                  widget.onQuotaGoodStudyQtyChanged(int.tryParse(value) ?? 0);
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
                'จำนวนที่รับ กิจกรรมดี กองพัฒฯ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.quotaGoodActivitySDDQty.toString(),
                onChanged: (value) {
                  widget.onQuotaGoodActivitySDDQtyChanged(
                      int.tryParse(value) ?? 0);
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
                'จำนวนที่รับ กิจกรรมดี สถาบันภาษา',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.quotaGoodActivityLIQty.toString(),
                onChanged: (value) {
                  widget.onQuotaGoodActivityLIQtyChanged(
                      int.tryParse(value) ?? 0);
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
                'จำนวนที่รับ กิจกรรมดี ดนตรีสากล',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.quotaGoodActivityIMQty.toString(),
                onChanged: (value) {
                  widget.onQuotaGoodActivityIMQtyChanged(
                      int.tryParse(value) ?? 0);
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
                'จำนวนที่รับ ประเภทกีฬาดี',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.quotaGoodSportQty.toString(),
                onChanged: (value) {
                  widget.onQuotaGoodSportQtyChanged(int.tryParse(value) ?? 0);
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
                'จำนวนที่รับ ประเภทคนดี',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.quotaGoodPersonQty.toString(),
                onChanged: (value) {
                  widget.onQuotaGoodPersonQtyChanged(int.tryParse(value) ?? 0);
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
