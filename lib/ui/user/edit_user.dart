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

class EditUserDetailScreen extends StatefulWidget {
  final UserPayload userPayload;
  const EditUserDetailScreen({super.key, required this.userPayload});

  @override
  _EditUserDetailScreenState createState() => _EditUserDetailScreenState();
}

class _EditUserDetailScreenState extends State<EditUserDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedRole;
  List<String> roleEnum = ['user', 'admin'];
  late String _id;
  late String _username;
  late String _email;
  late String _name;
  late String _surname;
  late String _phone;
  late String _role;
  late String _faculty;

  @override
  void initState() {
    super.initState();

    _id = widget.userPayload.id ?? "";
    _username = widget.userPayload.username ?? "";
    _email = widget.userPayload.email ?? "";
    if (widget.userPayload.name != null) {
      _name = widget.userPayload.name!;
    } else {
      _name = "";
    }
    if (widget.userPayload.surname != null) {
      _surname = widget.userPayload.surname!;
    } else {
      _name = "";
    }

    _phone = widget.userPayload.phone ?? "";
    _role = widget.userPayload.role ?? "";
    _faculty = widget.userPayload.faculty ?? "";
    _selectedRole = widget.userPayload.role ?? "";
  }

  void _navigateToAllUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllUserScreen()),
    );
  }

  _updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final url =
            Uri.http(BASEURL, "$ENDPOINT/users/update/${_id.toString()}");
        final fdata = {
          'username': _username,
          'email': _email,
          'name': _name,
          'surname': _surname,
          'phone': _phone,
          'role': _role,
          'faculty': _faculty,
        };
        final token = await LocalStorageUtil.getItem('token');

        final update = await http.patch(url, body: jsonEncode(fdata), headers: {
          'Authorization': 'Bearer ${token.toString()}',
          'Content-Type': 'application/json',
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลสำเร็จ'),
          backgroundColor: Colors.green,
        ));
        UserModel data = UserModel.fromJson(jsonDecode(update.body));
        UserPayload payload = data.payload!;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailScreen(userPayload: payload),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลไม่สำเร็จ ระบบขัดข้อง'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _deleteUser() async {
    final token = await LocalStorageUtil.getItem('token');
    final url =
        Uri.http(BASEURL, "$ENDPOINT/users/delete/${widget.userPayload.id}");
    final header = {
      'Authorization': 'Bearer ${token.toString()}',
      'Content-Type': 'application/json'
    };
    final response = await http.delete(url, headers: header);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('ลบข้อมูลสำเร็จ'),
        backgroundColor: Colors.green,
      ));
      // ignore: use_build_context_synchronously
      _navigateToAllUser();
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
                              title: 'คุณต้องการลบหรือไม่ ?',
                              description:
                                  'หากคุณลบข้อมูลสำเร็จแล้วจะไม่สามารถกู้คืนได้',
                              onNo: () => {Navigator.of(context).pop()},
                              onYes: _deleteUser,
                              btnColor: Colors.red,
                              btnText: 'ลบ',
                              btnIcon: Icons.delete,
                            ),
                            ConfirmDialog(
                              title: 'คุณต้องการแก้ไขข้อมูล ?',
                              description: 'คุณต้องการแก้ไขข้อมูลใช่หรือไม่',
                              onNo: () => {Navigator.of(context).pop()},
                              onYes: _updateUser,
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
