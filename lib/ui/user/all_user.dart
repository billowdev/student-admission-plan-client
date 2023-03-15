import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/course/add_course_ui.dart';
import 'package:project/ui/user/detail_user.dart';
import '../../common/utils/decoded_token_util.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/search_bar.widget.dart';
import 'package:http/http.dart' as http;

import 'models/user_model.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  late String _token = "";
  List<UserPayload> usersData = [];
  late String _decodedRole = "";
  @override
  void initState() {
    super.initState();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          _token = value ?? "";
        }));

    setState(() {
      _getRole();
      _getUsers();
    });
  }

  _getRole() async {
    final String role = await decodeRoleTokenUtil();
    setState(() {
      _decodedRole = role;
    });
  }
  // _getRole() async {
  //   final myToken = await LocalStorageUtil.getItem('token');
  //   final parts = myToken!.split('.');
  //   final payload = parts[1];
  //   final paddedPayload = payload.padRight((payload.length + 3) & ~3, '=');
  //   final decoded = utf8.decode(base64Url.decode(paddedPayload));
  //   final Map<String, dynamic> decodedJson = json.decode(decoded);
  //   final String decodedRole = decodedJson['role'];

  //   setState(() {
  //     _decodedRole = decodedRole;
  //   });
  // }

  _getUsers() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/users/get-all');
    final token = await LocalStorageUtil.getItem('token');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      UserModel userResponse = UserModel.fromJson(jsonDecode(response.body));

      setState(() {
        usersData = userResponse.payload!;
      });
    }
  }

  _getUsersKeyword(String? keyword) async {
    final queryParam = {"keyword": keyword};

    Uri url = Uri.http(BASEURL, '$ENDPOINT/users/get-all', queryParam);
    final token = await LocalStorageUtil.getItem('token');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${token.toString()}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      UserModel data = UserModel.fromJson(jsonDecode(response.body));

      setState(() {
        usersData = data.payload!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(txtTitle: 'สมาชิก'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SearchBar(
                onTextChanged: (String value) {
                  if (value != "") {
                    _getUsersKeyword(value);
                  } else {
                    _getUsers();
                  }
                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showCheckboxColumn: false,
                  sortAscending: true,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: IgnorePointer(
                        ignoring: true,
                        child: Text(
                          'ชื่อ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: IgnorePointer(
                        ignoring: true,
                        child: Text(
                          'นามสกุล',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: IgnorePointer(
                        ignoring: true,
                        child: Text(
                          'อีเมล',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                        label: Text(
                      'ชื่อผู้ใช้',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      'บทบาท',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    )),
                  ],
                  rows: usersData.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text("${data.name}")),
                        DataCell(Text("${data.surname}")),
                        DataCell(Text("${data.email}")),
                        DataCell(Text("${data.username}")),
                        DataCell(Text("${data.role}")),
                      ],
                      selected: false, // Add this line to remove the borders
                      onSelectChanged: (isSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetailScreen(
                                    userPayload: data,
                                  )),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: _decodedRole == "admin",
                    child: SizedBox(
                      width: 80, // adjust the width to your desired size
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddCourseScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            SizedBox(
                                width:
                                    2), // Add some space between icon and text
                            Text('เพิ่ม'),
                          ],
                        ),
                      ),
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
                        Icon(Icons.arrow_back_ios_new),
                        SizedBox(
                            width: 5), // Add some space between icon and text
                        Text('กลับ'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        drawer: const DrawerMenuWidget(),
      ),
    );
  }
}
