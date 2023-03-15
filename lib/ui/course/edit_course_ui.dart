import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/common/utils/local_storage_util.dart';
import 'package:project/common/widgets/confirm_button_widget.dart';
import 'package:project/ui/course/models/course.model.dart';
import '../../common/constants/constants.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';

class EditCourseDetailScreen extends StatefulWidget {
  final CoursePayload detail;
  const EditCourseDetailScreen({super.key, required this.detail});

  @override
  _EditCourseDetailScreenState createState() => _EditCourseDetailScreenState();
}

class _EditCourseDetailScreenState extends State<EditCourseDetailScreen> {
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
            Uri.http(BASEURL, "$ENDPOINT/courses/update/${widget.detail.id}");
        final fdata = {
          'major': _major,
          'degree': _degree,
          'faculty': _faculty,
          'detail': _detail,
        };
        final header = {'Content-Type': 'application/json'};
        await http.patch(url, headers: header, body: jsonEncode(fdata));
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

  Future<void> _deleteCourse() async {
    final token = await LocalStorageUtil.getItem('token');
    final header = {
      'Authorization': 'Bearer ${token.toString()}',
      'Content-Type': 'application/json',
    };
    final url =
        Uri.http(BASEURL, "$ENDPOINT/courses/delete/${widget.detail.id}");
    final response = await http.delete(url, headers: header);
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
                            ConfirmDialog(
                              title: 'คุณต้องการลบหรือไม่ ?',
                              description:
                                  'หากคุณลบข้อมูลสำเร็จแล้วจะไม่สามารถกู้คืนได้',
                              onNo: () => {Navigator.of(context).pop()},
                              onYes: _deleteCourse,
                              btnColor: Colors.red,
                              btnText: 'ลบ',
                              btnIcon: Icons.delete,
                            ),
                            ConfirmDialog(
                              title: 'แก้ไขข้อมูล ?',
                              description: 'คุณต้องการแก้ไขข้อมูลใช่หรือไม่',
                              onNo: () => {Navigator.of(context).pop()},
                              onYes: _updateCourse,
                              btnColor: Colors.green,
                              btnText: 'แก้ไข',
                              btnIcon: Icons.edit,
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
