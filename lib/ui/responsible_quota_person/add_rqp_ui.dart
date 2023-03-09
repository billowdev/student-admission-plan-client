import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/ui/responsible_quota_person/responsible_quota_person_ui.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';

class AddRQPScreen extends StatefulWidget {
  const AddRQPScreen({super.key});

  @override
  _AddRQPScreenState createState() => _AddRQPScreenState();
}

class _AddRQPScreenState extends State<AddRQPScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _year = "";
  late String _name = "";
  late String _surname = "";
  late String _agency = "";
  late String _phone = "";
  late String _quota = "GOOD_STUDY";
  late String _token = "";
  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  @override
  void initState() {
    super.initState();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          _token = value ?? "";
        }));
  }

  Future<void> _createRQP() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final url = Uri.http(BASEURL, "$ENDPOINT/rqp/create");

    final data = {
      'year': _year,
      'name': _name,
      'surname': _surname,
      'agency': _agency,
      'phone': _phone,
      'quota': _quota,
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
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AllResponseibleQuotaPersonScreen()),
        );
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

  late String _selectedQuota = "good_study";
  List<List<String>> quota = [
    ['เรียนดี', 'good_study'],
    ['คนดี', 'good_person'],
    ['กีฬาดี', 'good_sport'],
    ['กิจกรรมดี', 'good_activity']
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'เพิ่มข้อมูลผู้รับผิดชอบโควตา'),
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
                          'ปีการศึกษา',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: "",
                          onChanged: (value) {
                            _year = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกปีการศึกษา';
                            }
                            return null;
                          },
                        ),
                        const Text(
                          'ประเภทโควตา',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: quota.map((List<String> value) {
                            return RadioListTile(
                              title: Text(value[0]),
                              value: value[1],
                              groupValue: _selectedQuota,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedQuota = newValue!;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'ชื่อผู้รับผิดชอบโควตา',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: "",
                          onChanged: (value) {
                            _name = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อผู้รับผิดชอบโควตา';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'นามสกุลผู้รับผิดชอบโควตา',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: "",
                          onChanged: (value) {
                            _name = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกนามสกุลผู้รับผิดชอบโควตา';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'หน่วยงาน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: "",
                          onChanged: (value) {
                            _agency = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อหน่วยงาน';
                            }
                            return null;
                          },
                          maxLines: 5,
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
                          initialValue: "",
                          onChanged: (value) {
                            _agency = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกเบอร์โทร';
                            }
                            return null;
                          },
                          maxLines: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: _createRQP,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.add),
                                  SizedBox(
                                      width:
                                          5), // Add some space between icon and text
                                  Text('เพิ่ม'),
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
                        ),
                      ])))),
      drawer: const DrawerMenuWidget(),
    ));
  }
}
