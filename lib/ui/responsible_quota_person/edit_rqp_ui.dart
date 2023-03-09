import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/ui/course/models/course.model.dart';
import '../../common/constants/constants.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';

class EditRQPScreen extends StatefulWidget {
  final CoursePayload detail;
  const EditRQPScreen({super.key, required this.detail});

  @override
  _EditRQPScreenState createState() => _EditRQPScreenState();
}

class _EditRQPScreenState extends State<EditRQPScreen> {
  // final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  //     GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  late String _major;
  late String _degree;
  late String _faculty;
  late String _detail;

  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  @override
  void initState() {
    super.initState();
    _major = widget.detail.major!;
    _degree = widget.detail.degree!;
    _faculty = widget.detail.faculty!;
    _detail = widget.detail.detail!;
  }

  void _navigateToAllCourse() {
    Navigator.pushReplacementNamed(context, '/all-course');
  }

  Future<void> _updateCourse() async {
    if (_formKey.currentState!.validate()) {
      try {
        final url =
            Uri.http(BASEURL, "/api/v1/courses/update/${widget.detail.id}");
        final fdata = {
          'major': _major,
          'degree': _degree,
          'faculty': _faculty,
          'detail': _detail,
        };
        final header = {'Content-Type': 'application/json'};
        await client.patch(url, headers: header, body: jsonEncode(fdata));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลสำเร็จ'),
          backgroundColor: Colors.green,
        ));

        _navigateToAllCourse();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลไม่สำเร็จ ระบบขัดข้อง'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
  // Future<void> _updateCourse() async {
  //   if (_formKey.currentState!.validate()) {
  //     final url = Uri.http(BASEURL, "/courses/update/${widget.detail.id}");
  //     var data = {
  //       'major': _major,
  //       'degree': _degree,
  //       'faculty': _faculty,
  //       'detail': _detail,
  //     };
  //     final header = {'Content-Type': 'application/json'};
  //     final response =
  //         await client.patch(url, headers: header, body: jsonEncode(data));
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);

  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('อัปเดตข้อมูลสำเร็จ'),
  //         backgroundColor: Colors.green,
  //       ));
  //       // Navigator.pop(context);
  //       Navigator.pushReplacementNamed(context, '/all-course');
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Failed to update course.'),
  //         backgroundColor: Colors.red,
  //       ));
  //     }
  //   }
  // }

  Future<void> _deleteCourse() async {
    final url = Uri.http(BASEURL, "/courses/delete/${widget.detail.id}");
    final header = {'Content-Type': 'application/json'};
    final response = await client.delete(url, headers: header);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('ลบข้อมูลสำเร็จ'),
        backgroundColor: Colors.green,
      ));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/all-course');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to delete course.'),
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
                        const SizedBox(height: 20),
                        const Text(
                          'หลักสูตร',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _degree,
                          onChanged: (value) {
                            _degree = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อหลักสูตร';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'คณะ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _faculty,
                          onChanged: (value) {
                            _faculty = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อคณะ';
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
                          initialValue: _detail,
                          onChanged: (value) {
                            _detail = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกรายละเอียด';
                            }
                            return null;
                          },
                          maxLines: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: _deleteCourse,
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
