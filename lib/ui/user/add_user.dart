import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/ui/course/models/course.model.dart';
import 'package:project/ui/user/all_user.dart';
import 'package:project/ui/user/detail_user.dart';
import 'package:project/ui/user/models/user_model.dart';
import 'package:project/ui/user/models/user_model.dart';
import '../../common/constants/constants.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/confirm_button_widget.dart';
import '../../common/widgets/drawer.widget.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedRole;
  List<String> roleEnum = ['user', 'admin'];
  late String _username = "";
  late String _email = "";
  late String _name = "-";
  late String _surname = "-";
  late String _phone = "-";
  late String _role = "user";
  late String _faculty = "";
  late String _password_confirmed = "";
  late String _password = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _username = "";
      _email = "";
      _name = "-";
      _surname = "-";
      _phone = "-";
      _role = "user";
      _faculty = "-";
      _selectedRole = "user";
      _password_confirmed = "";
      _password = "";
    });
  }

  void _navigateToAllUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllUserScreen()),
    );
  }

  _addUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final url = Uri.http(BASEURL, "$ENDPOINT/users/create");
        final fdata = {
          'username': _username,
          'email': _email,
          'name': _name,
          'surname': _surname,
          'phone': _phone,
          'role': _role,
          'password': _password,
          'faculty': _faculty,
        };
        final token = await LocalStorageUtil.getItem('token');
        final header = {
          'Authorization': 'Bearer ${token.toString()}',
          'Content-Type': 'application/json',
        };
        final response =
            await http.post(url, body: jsonEncode(fdata), headers: header);
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('เพิ่มข้อมูลสำเร็จ'),
            backgroundColor: Colors.green,
          ));
          _navigateToAllUser();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('เพิ่มข้อมูลไม่สำเร็จ ระบบขัดข้อง'),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('เพิ่มข้อมูลไม่สำเร็จ ระบบขัดข้อง'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'เพิ่มข้อมูลสมาชิก'),
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
                          'รหัสผ่าน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _password,
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกรหัสผ่าน';
                            }
                            if (_password != _password_confirmed) {
                              return 'กรุณากรอกรหัสผ่านให้ตรงกัน';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'รหัสผ่านอีกครั้ง',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _password_confirmed,
                          onChanged: (value) {
                            _password_confirmed = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกรหัสผ่านอีกครั้ง';
                            }
                            if (_password != _password_confirmed) {
                              return 'กรุณากรอกรหัสผ่านให้ตรงกัน';
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
                            if (value == null || value.isEmpty) {
                              _name = "-";
                            }
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
                          initialValue: _surname,
                          onChanged: (value) {
                            _surname = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              _surname = "-";
                            }
                            return null;
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
                        const SizedBox(height: 20),
                        const Text(
                          'เบอร์โทร',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _phone,
                          onChanged: (value) {
                            _phone = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกเบอร์โทร';
                            } else {
                              _phone = "-";
                            }
                            return null;
                          },
                        ),
                        const Text(
                          'บทบาท',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: roleEnum.map((String value) {
                            return RadioListTile(
                              title: Text(value),
                              value: value,
                              groupValue: _role,
                              onChanged: (newValue) {
                                setState(() {
                                  _role = newValue!;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ConfirmDialog(
                              title: 'คุณต้องการเพิ่มสมาชิก ?',
                              description: 'คุณต้องการเพิ่มสมาชิกใช่หรือไม่',
                              onNo: () => {Navigator.of(context).pop()},
                              onYes: _addUser,
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
                        )
                      ])))),
      drawer: const DrawerMenuWidget(),
    ));
  }
}
