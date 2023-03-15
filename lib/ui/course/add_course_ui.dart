import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/widgets/confirm_button_widget.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _major;
  late String _degree;
  late String _faculty;
  late String _detail;
  late String _token = "";
  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  @override
  void initState() {
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          _token = value ?? "";
        }));
    super.initState();
  }

  Future<void> _createCourse() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final url = Uri.http(BASEURL, "$ENDPOINT/courses/create");
    final data = {
      'major': _major,
      'degree': _degree,
      'faculty': _faculty,
      'detail': _detail,
    };
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token'
    };
    try {
      final response =
          await client.post(url, headers: header, body: jsonEncode(data));

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('เพิ่มข้อมูลสำเร็จ'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, '/all-course');
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create course.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while creating the course.'),
          backgroundColor: Colors.red,
        ),
      );
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
                          initialValue: "",
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
                          initialValue: "",
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
                          initialValue: "",
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
                          initialValue: "",
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
                         
                             ConfirmDialog(
                              title: 'เพิ่มข้อมูล ?',
                              description: 'คุณต้องการเพิ่มข้อมูลใช่หรือไม่',
                              onNo: () => {Navigator.of(context).pop()},
                              onYes: _createCourse,
                              btnColor: Colors.green,
                              btnText: 'เพิ่ม',
                              btnIcon: Icons.add,
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
                        ),
                      ])))),
      drawer: const DrawerMenuWidget(),
    ));
  }
}
