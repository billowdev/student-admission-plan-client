import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/ui/course/models/course.model.dart';
import 'package:project/ui/extra_admission_plan/models/extra_admission_plan_array.dart';
import '../../common/constants/constants.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';
import 'extra_admission_plan_faculty_ui.dart';

class EditExtraAdmissionPlanCourseScreen extends StatefulWidget {
  final String eapId;
  final String detail;
  final String major;
  final int qty;
  final String degree;
  final String faculty;
  final String facultyFilter;
  final String yearFilter;
  const EditExtraAdmissionPlanCourseScreen(
      {super.key,
      required this.detail,
      required this.major,
      required this.degree,
      required this.faculty,
      required this.facultyFilter,
      required this.yearFilter,
      required this.qty,
      required this.eapId});

  @override
  _EditExtraAdmissionPlanCourseScreenState createState() =>
      _EditExtraAdmissionPlanCourseScreenState();
}

class _EditExtraAdmissionPlanCourseScreenState
    extends State<EditExtraAdmissionPlanCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _major;
  late String _degree;

  late String _faculty;
  late String _detail;

  late int _qty;
  late String _year;

  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  @override
  void initState() {
    super.initState();
    _qty = widget.qty;
    _year = widget.yearFilter;

    _faculty = widget.faculty;
    _degree = widget.degree;
    _major = widget.major;
  }

  _navigateToExtraAdmissionPlanFaculty() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExtraAdmissionPlanFaculty(
                  facultyFilter: widget.faculty,
                  yearFilter: widget.yearFilter,
                )));
  }

  Future<void> _updateExtraAdmissionPlan() async {
    if (_formKey.currentState!.validate()) {
      try {
        final url = Uri.http(BASEURL, "/api/v1/eap/update/${widget.eapId}");
        final fdata = {
          'qty': _qty,
          'year': _year,
        };
        final header = {'Content-Type': 'application/json'};
        await client.patch(url, headers: header, body: jsonEncode(fdata));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลสำเร็จ'),
          backgroundColor: Colors.green,
        ));
        _navigateToExtraAdmissionPlanFaculty();
        // ignore: use_build_context_synchronously
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลไม่สำเร็จ ระบบขัดข้อง'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _deleteExtraAdmissionPlan() async {
    final url = Uri.http(BASEURL, "/eap/delete/${widget.eapId}");
    final header = {'Content-Type': 'application/json'};
    final response = await client.delete(url, headers: header);
    if (response.statusCode == 204) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('ลบข้อมูลสำเร็จ'),
        backgroundColor: Colors.green,
      ));
      // ignore: use_build_context_synchronously
      _navigateToExtraAdmissionPlanFaculty();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('ลบข้อมูลไม่สำเร็จ'),
        backgroundColor: Colors.red,
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'แก้ไขข้อมูลหลักสูตร'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "แผนการรับนักศึกษา ภาคพิเศษ (กศ.ป.) \nประจำปีการศึกษา ${_year.toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )),
                        Table(
                          children: [
                            _buildTableRow('ชื่อหลักสูตร', _major.toString()),
                            _buildTableRow('หลักสูตร', _degree.toString()),
                            _buildTableRow('คณะ', _faculty.toString()),
                          ],
                        ),
                        const Text(
                          'ปีการศึกษา',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _year,
                          onChanged: (value) {
                            _year = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกปีการศึกษา';
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
                          initialValue: _qty.toString(),
                          onChanged: (value) {
                            _qty = int.tryParse(value)!;
                            ;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกจำนวนที่รับ';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: _deleteExtraAdmissionPlan,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(Icons.delete),
                                  const SizedBox(
                                      width:
                                          5), // Add some space between icon and text
                                  const Text('ลบ'),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: _updateExtraAdmissionPlan,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.edit),
                                  SizedBox(
                                      width:
                                          5), // Add some space between icon and text
                                  Text('แก้ไข'),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.brown,
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.cancel),
                                  SizedBox(
                                      width:
                                          5), // Add some space between icon and text
                                  Text('ยกเลิก'),
                                ],
                              ),
                            ),
                          ],
                        )
                      ])))),
      drawer: const DrawerMenuWidget(),
    ));
  }

  TableRow _buildTableRow(String title, String content) {
    return TableRow(children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    ]);
  }
}
