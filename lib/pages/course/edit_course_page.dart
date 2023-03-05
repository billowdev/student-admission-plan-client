import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/pages/course/all_course_page.dart';
import 'package:project/pages/course/course_detail_page.dart';
import 'package:project/pages/course/models/course.model.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';

class EditCourseDetailScreen extends StatefulWidget {
  final CoursePayload detail;
  const EditCourseDetailScreen({super.key, required this.detail});

  @override
  _EditCourseDetailScreenState createState() => _EditCourseDetailScreenState();
}

class _EditCourseDetailScreenState extends State<EditCourseDetailScreen> {
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
    _major = widget.detail.major!;
    _degree = widget.detail.degree!;
    _faculty = widget.detail.faculty!;
    _qualification = widget.detail.qualification!;
  }

  Future<void> _updateCourse() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.http(apiUrl, "/courses/update/${widget.detail.id}");
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

  Future<void> _deleteCourse() async {
    final url = Uri.http(apiUrl, "/courses/delete/${widget.detail.id}");
    final header = {'Content-Type': 'application/json'};
    final response = await client.delete(url, headers: header);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('ลบข้อมูลสำเร็จ'),
        backgroundColor: Colors.green,
      ));
      Navigator.pushReplacementNamed(context, '/all-course');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete course.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(
        txtTitle: 'แก้ไขข้อมูลหลักสูตร'
      ),
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
                        Text(
                          'หลักสูตร',
                          style: const TextStyle(
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
                        Text(
                          'คณะ',
                          style: const TextStyle(
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
                        Text(
                          'รายละเอียด',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _qualification,
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
                              onPressed: _deleteCourse,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                primary: Colors.white,
                              ),
                              child: Text('ลบ'),
                            ),
                            TextButton(
                              onPressed: _updateCourse,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                primary: Colors.white,
                              ),
                              child: Text('แก้ไข'),
                            ),
                            SizedBox(width: 10),
                          ],
                        )
                      ])))),
      drawer: DrawerMenuWidget(),
    ));
  }
}
