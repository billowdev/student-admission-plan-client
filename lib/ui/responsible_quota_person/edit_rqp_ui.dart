import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/ui/responsible_quota_person/detail_rqp_ui.dart';
import 'package:project/ui/responsible_quota_person/responsible_quota_person_ui.dart';
import '../../common/constants/constants.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';
import 'models/rqp_model.dart';

class EditRQPScreen extends StatefulWidget {
  final String year;
  final String id;
  final String name;
  final String surname;
  final String agency;
  final String phone;
  final String quota;
  const EditRQPScreen(
      {super.key,
      required this.year,
      required this.name,
      required this.surname,
      required this.agency,
      required this.phone,
      required this.quota,
      required this.id});

  @override
  _EditRQPScreenState createState() => _EditRQPScreenState();
}

class _EditRQPScreenState extends State<EditRQPScreen> {
  // final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  //     GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  late String _year = "";
  late String _name = "";
  late String _surname = "";
  late String _agency = "";
  late String _phone = "";
  late String _quota = "";
  late String token = "";
  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  late String _selectedQuota = "good_study";

  List<List<String>> quota = [
    ['เรียนดี', 'good_study'],
    ['คนดี', 'good_person'],
    ['กีฬาดี', 'good_sport'],
    ['กิจกรรมดี', 'good_activity']
  ];
  @override
  void initState() {
    super.initState();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
    _year = widget.year;
    _name = widget.name;
    _surname = widget.surname;
    _agency = widget.agency;
    _phone = widget.phone;
    _quota = widget.quota;
  }


  Future<void> _updateRPQ() async {
    if (_formKey.currentState!.validate()) {
      try {
        final url = Uri.http(BASEURL, "/api/v1/rqp/update/${widget.id}");
        final fdata = {
          'year': _year,
          'name': _name,
          'surname': _surname,
          'agency': _agency,
          'phone': _phone,
          'quota': _quota,
        };
        final header = {'Content-Type': 'application/json'};
        await client.patch(url, headers: header, body: jsonEncode(fdata));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลสำเร็จ'),
          backgroundColor: Colors.green,
        ));

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailRQPScreen(
                    id: widget.id,
                    agency: _agency,
                    name: _name,
                    surname: _surname,
                    phone: _phone,
                    quota: _quota,
                    year: _year,
                  )),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตข้อมูลไม่สำเร็จ ระบบขัดข้อง'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _deleteRQP() async {
    final url = Uri.http(BASEURL, "/rqp/delete/${widget.id}");
    final header = {'Content-Type': 'application/json'};
    final response = await client.delete(url, headers: header);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('ลบข้อมูลสำเร็จ'),
        backgroundColor: Colors.green,
      ));
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AllResponseibleQuotaPersonScreen()));
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
                              groupValue: _quota,
                              onChanged: (newValue) {
                                setState(() {
                                  _quota = newValue!;
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
                          initialValue: _name,
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
                          initialValue: _surname,
                          onChanged: (value) {
                            _surname = value;
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
                          initialValue: _agency,
                          onChanged: (value) {
                            _agency = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อหน่วยงาน';
                            }
                            return null;
                          },
                          maxLines: 1,
                        ),
                        const SizedBox(height: 10),
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
                          maxLines: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: _deleteRQP,
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
                              onPressed: _updateRPQ,
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
