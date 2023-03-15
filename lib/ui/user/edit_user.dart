import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/ui/course/models/course.model.dart';
import 'package:project/ui/user/all_user.dart';
import 'package:project/ui/user/models/user_model.dart';
import '../../common/constants/constants.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';

class EditUserDetailScreen extends StatefulWidget {
  final UserPayload userPayload;
  const EditUserDetailScreen({super.key, required this.userPayload});

  @override
  _EditUserDetailScreenState createState() => _EditUserDetailScreenState();
}

class _EditUserDetailScreenState extends State<EditUserDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _id;
  late String _username;
  late String _email;
  late String _name;
  late String _surname;
  late String _phone;
  late String _role;
  late String _faculty;

  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  @override
  void initState() {
    super.initState();

    _id = widget.userPayload.id!;
    _username = widget.userPayload.username!;
    _email = widget.userPayload.email!;
    _name = widget.userPayload.name!;
    _surname = widget.userPayload.surname!;
    _phone = widget.userPayload.phone!;
    _role = widget.userPayload.role!;
    _faculty = widget.userPayload.faculty!;
  }

  void _navigateToAllUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllUserScreen()),
    );
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final token = await LocalStorageUtil.getItem('token');
        final url = Uri.http(
            BASEURL, "$ENDPOINT/users/update/${widget.userPayload.id}");
        final fdata = {
          'username': _username,
          'email': _email,
          'name': _name,
          'surname': _surname,
          'phone': _phone,
          'role': _role,
          'faculty': _faculty,
        };
        final header = {
          'Autorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
        await client.patch(url, headers: header, body: jsonEncode(fdata));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลสำเร็จ'),
          backgroundColor: Colors.green,
        ));

        _navigateToAllUser();
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
    final url =
        Uri.http(BASEURL, "$ENDPOINT/users/delete/${widget.userPayload.id}");
    final header = {
      'Authorization': 'Bearer ${token.toString()}',
      'Content-Type': 'application/json'
    };
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
                        const SizedBox(height: 20),
                        const Text(
                          'ชื่อผู้ใช้',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _username,
                          onChanged: (value) {
                            _username = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อผู้ใช้';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'อีเมล',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _email,
                          onChanged: (value) {
                            _email = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกอีเมล';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'ชื่อ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _name,
                          onChanged: (value) {
                            _name = value;
                          },
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'กรุณากรอกชื่อ';
                            // }
                            // return null;
                          },
                          maxLines: 1,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'นามสกุล',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _name,
                          onChanged: (value) {
                            _name = value;
                          },
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'กรุณากรอกนามสกุล';
                            // }
                            // return null;
                          },
                          maxLines: 1,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'สังกัด',
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
                              onPressed: _updateUser,
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
