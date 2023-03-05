import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/ui/course/all_course_ui.dart';
import 'package:project/ui/course/course_detail_ui.dart';
import 'package:project/ui/course/models/course.model.dart';
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
  late String _qualification;
  static String apiUrl = dotenv.env['API_URL'].toString();

  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  @override
  void initState() {
    super.initState();
  }

  Future<void> _createCourse() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.http(apiUrl, "/courses/create");
      var data = {
        'major': _major,
        'degree': _degree,
        'faculty': _faculty,
        'qualification': _qualification,
      };
      final header = {'Content-Type': 'application/json'};
      final response =
          await client.patch(url, headers: header, body: jsonEncode(data));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('อัปเดตข้อมูลสำเร็จ'),
          backgroundColor: Colors.green,
        ));
        // Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/all-course');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update course.'),
          backgroundColor: Colors.red,
        ));
      }
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
                        Text(
                          'ชื่อหลักสูตร',
                          style: const TextStyle(
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
                        Text(
                          'หลักสูตร',
                          style: const TextStyle(
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
                        Text(
                          'คณะ',
                          style: const TextStyle(
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
                        Text(
                          'รายละเอียด',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: "",
                          onChanged: (value) {
                            _qualification = value;
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.brown,
                                primary: Colors.white,
                              ),
                              child: Text('ยกเลิก'),
                            ),
                            TextButton(
                              onPressed: _createCourse,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                primary: Colors.white,
                              ),
                              child: Text('เพิ่ม'),
                            ),
                            SizedBox(width: 10),
                          ],
                        )
                      ])))),
      drawer: DrawerMenuWidget(),
    ));
  }
}
