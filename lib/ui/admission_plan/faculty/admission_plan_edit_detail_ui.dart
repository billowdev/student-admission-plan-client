import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import '../../../common/widgets/appbar.widget.dart';
import '../../../common/widgets/drawer.widget.dart';
import '../models/admission_plan_faculty_model.dart';

class EditAdmissionPlanDetailScreen extends StatefulWidget {
  final AdmissionPlanFacultyPayload detail;
  const EditAdmissionPlanDetailScreen({super.key, required this.detail});

  @override
  _EditAdmissionPlanDetailScreenState createState() =>
      _EditAdmissionPlanDetailScreenState();
}

class _EditAdmissionPlanDetailScreenState
    extends State<EditAdmissionPlanDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late String _major;
  late String _degree;
  late String _faculty;
  late String _detail;

  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  @override
  void initState() {
    super.initState();
    // _major = widget.detail.major!;
    // _degree = widget.detail.degree!;
    // _faculty = widget.detail.faculty!;
    // _detail = widget.detail.detail!;
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

  void _navigateToAllCourse() {
    Navigator.pushReplacementNamed(context, '/api/v1/all-course');
  }

  Future<void> _updateCourse() async {
    if (_formKey.currentState!.validate()) {
      try {
        final url =
            Uri.http(BASEURL, "$ENDPOINT/courses/update/${widget.detail.id}");
        final fdata = {
          'major': _major,
          'degree': _degree,
          'faculty': _faculty,
          'detail': _detail,
        };
        final header = {'Content-Type': 'application/json'};
        await client.patch(url, headers: header, body: jsonEncode(fdata));
        _showSnackBar('อัปเดตข้อมูลสำเร็จ', Colors.green);
        _navigateToAllCourse();
      } catch (e) {
        _showSnackBar('แก้ไขข้อมูลไม่สำเร็จ ระบบขัดข้อง', Colors.red);
      }
    }
  }

  Future<void> _deleteAdmissionPlan() async {
    final url =
        Uri.http(BASEURL, "$ENDPOINT/courses/delete/${widget.detail.id}");
    final header = {'Content-Type': 'application/json'};
    final response = await client.delete(url, headers: header);
    if (response.statusCode == 200) {
      _showSnackBar('ลบข้อมูลสำเร็จ', Colors.green);

      Navigator.pushReplacementNamed(context, '/all-course');
    } else {
      _showSnackBar('ลบข้อมูลไม่สำเร็จ ระบบขัดข้อง', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'แก้ไขข้อมูลแผนการรับนักศึกษา'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'ชื่อหลักสูตร',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _major,
                          onChanged: (value) {
                            _major = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อหลักสูตร';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 20),
                        // const Text(
                        //   'หลักสูตร',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // TextFormField(
                        //   initialValue: _degree,
                        //   onChanged: (value) {
                        //     _degree = value;
                        //   },
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'กรุณากรอกชื่อหลักสูตร';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // const SizedBox(height: 20),
                        // const Text(
                        //   'คณะ',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // TextFormField(
                        //   initialValue: _faculty,
                        //   onChanged: (value) {
                        //     _faculty = value;
                        //   },
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'กรุณากรอกชื่อคณะ';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // const SizedBox(height: 20),
                        // const Text(
                        //   'รายละเอียด',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // TextFormField(
                        //   initialValue: _detail,
                        //   onChanged: (value) {
                        //     _detail = value;
                        //   },
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'กรุณากรอกรายละเอียด';
                        //     }
                        //     return null;
                        //   },
                        //   maxLines: 5,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: _deleteAdmissionPlan,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.delete),
                                  SizedBox(
                                      width:
                                          5), // Add some space between icon and text
                                  Text('ลบ'),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: _updateCourse,
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
}
