import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/utils/local_storage_util.dart';
import '../../../common/widgets/appbar.widget.dart';
import '../../../common/widgets/drawer.widget.dart';
import '../models/admission_plan_faculty_model.dart';
import 'all_faculty_admission_plan_ui.dart';

class EditAdmissionPlanDetailScreen extends StatefulWidget {
  final AdmissionPlanFacultyPayload detail;
  final String admissionPlanId;
  final String major;
  final String degree;
  final String faculty;
  final String year;
  final String facultyFilter;
  final String yearFilter;
  const EditAdmissionPlanDetailScreen(
      {super.key,
      required this.detail,
      required this.major,
      required this.degree,
      required this.faculty,
      required this.year,
      required this.admissionPlanId,
      required this.facultyFilter,
      required this.yearFilter});

  @override
  _EditAdmissionPlanDetailScreenState createState() =>
      _EditAdmissionPlanDetailScreenState();
}

class _EditAdmissionPlanDetailScreenState
    extends State<EditAdmissionPlanDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late String _token;
  late String _major;
  late String _degree;
  late String _faculty;
  late String _year;

  late bool _quotaStatus;

  late String _quotaSpecificSubject;
  late int _quotaQty;
  late String _quotaDetail;
  late int _sumQty;

  late bool _directStatus;
  late String _directSpecificSubject;
  late int _directQty;
  late String _directDetail;

  late bool _cooperationStatus;
  late String _cooperationSpecificSubject;
  late int _cooperationQty;
  late String _cooperationDetail;

  late int _studyGroup;

  // late bool _quotaStatus;

  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  @override
  void initState() {
    super.initState();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          _token = value ?? "";
        }));
    _major = widget.major;
    _degree = widget.degree;
    _faculty = widget.faculty;
    _year = widget.year;

    _quotaStatus = widget.detail.quotaStatus!;
    _studyGroup = widget.detail.studyGroup!;

    // ========================== quota ==========================

    if (widget.detail.quotaSpecificSubject == "") {
      _quotaSpecificSubject = "-";
    } else {
      _quotaSpecificSubject = widget.detail.quotaSpecificSubject!;
    }

    _quotaQty = widget.detail.quotaQty!;

    if (widget.detail.quotaDetail != "") {
      _quotaDetail = widget.detail.quotaDetail!;
    } else {
      _quotaDetail = "-";
    }

    // ========================== direct ==========================
    _directStatus = widget.detail.directStatus!;

    if (widget.detail.directSpecificSubject == "") {
      _directSpecificSubject = "-";
    } else {
      _directSpecificSubject = widget.detail.directSpecificSubject!;
    }

    if (widget.detail.directQty != 0) {
      _directQty = widget.detail.directQty!;
    } else {
      _directQty = 0;
    }
    if (widget.detail.directDetail != "") {
      _directDetail = widget.detail.directDetail!;
    } else {
      _directDetail = "-";
    }

    // ========================== cooperation ==========================
    _cooperationStatus = widget.detail.cooperationStatus!;

    if (widget.detail.cooperationSpecificSubject == "") {
      _cooperationSpecificSubject = "-";
    } else {
      _cooperationSpecificSubject = widget.detail.cooperationSpecificSubject!;
    }

    if (widget.detail.cooperationQty != 0) {
      _cooperationQty = widget.detail.cooperationQty!;
    } else {
      _cooperationQty = 0;
    }
    if (widget.detail.cooperationDetail != "") {
      _cooperationDetail = widget.detail.cooperationDetail!;
    } else {
      _cooperationDetail = "-";
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

  void _navigateToAllAdmssionPlan() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdmissionPlanFaculty(
                  facultyFilter: widget.faculty,
                  yearFilter: widget.yearFilter,
                )));
  }

  Future<void> _updateAdmissionPlan() async {
    if (_formKey.currentState!.validate()) {
      try {
        late int qs; // _quotaStatus
        late int ds; // _directStatus
        late int cs; // _cooperationStatus
        if (_quotaStatus) {
          qs = 1;
        } else {
          qs = 0;
        }
        if (_directStatus) {
          ds = 1;
        } else {
          ds = 0;
        }

        if (_cooperationStatus) {
          cs = 1;
        } else {
          cs = 0;
        }

        final fdata = {
          'quotaStatus': qs,
          'quotaSpecificSubject': _quotaSpecificSubject,
          'quotaQty': _quotaQty,
          'quotaDetail': _quotaDetail,
          'directStatus': ds,
          'directSpecificSubject': _directSpecificSubject,
          'directQty': _directQty,
          'directDetail': _directDetail,
          'cooperationStatus': cs,
          'cooperationSpecificSubject': _cooperationSpecificSubject,
          'cooperationQty': _cooperationQty,
          'cooperationDetail': _cooperationDetail,
          'studyGroup': _studyGroup,
          'year': _year,
        };

        final url = Uri.http(BASEURL,
            "$ENDPOINT/admission-plans/update/${widget.admissionPlanId}");
        final header = {'Content-Type': 'application/json'};
        final response =
            await client.patch(url, headers: header, body: jsonEncode(fdata));
        if (response.statusCode == 200) {
          _showSnackBar('อัปเดตข้อมูลสำเร็จ', Colors.green);
          _navigateToAllAdmssionPlan();
        } else {
          _showSnackBar('แก้ไขข้อมูลไม่สำเร็จ ระบบขัดข้อง', Colors.red);
        }
      } catch (e) {
        _showSnackBar('แก้ไขข้อมูลไม่สำเร็จ ระบบขัดข้อง', Colors.red);
      }
    }
  }

  Future<void> _deleteAdmissionPlan() async {
    final url = Uri.http(
        BASEURL, "$ENDPOINT/admission-plans/delete/${widget.admissionPlanId}");
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token'
    };
    final response = await client.delete(url, headers: header);
    if (response.statusCode == 200) {
      _showSnackBar('ลบข้อมูลสำเร็จ', Colors.green);
      _navigateToAllAdmssionPlan();
    } else {
      _showSnackBar('ลบข้อมูลไม่สำเร็จ ระบบขัดข้อง', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'แก้ไขข้อมูลแผนการรับนักศึกษา'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "แผนการรับนักศึกษาประจำปีการศึกษา ${_year.toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )),
                        Table(
                          children: [
                            _buildTableRow('ชื่อหลักสูตร', _major.toString()),
                            _buildTableRow('หลักสูตร', _degree.toString()),
                            _buildTableRow('คณะ', _faculty.toString()),
                          ],
                        ),

                        // ====================================================================
                        // ====================================================================
                        // ====================================================================
                        const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "รอบที่ 1 รอบโควตา",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )),

                        // ====================================================================
                        // ====================================================================
                        // ====================================================================
                        Container(
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  const TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0),
                                      child: Text(
                                        "สถานะ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Switch(
                                      value: _quotaStatus,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _quotaStatus = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _quotaStatus,
                          child: SizedBox(
                              // width: 80, // adjust the width to your desired size
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'วิชาเฉพาะ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                initialValue: _quotaSpecificSubject,
                                onChanged: (value) {
                                  _quotaSpecificSubject = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    _quotaSpecificSubject = "-";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'จำนวนที่รับ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                initialValue:
                                    _quotaQty.toString(), // convert to string
                                onChanged: (value) {
                                  _quotaQty =
                                      int.tryParse(value)!; // convert to int
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกจำนวนที่รับ';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'รายละเอียดโควตา',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                initialValue: _quotaDetail,
                                onChanged: (value) {
                                  _quotaDetail = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกรายละเอียดโควตา';
                                  }
                                  return null;
                                },
                                maxLines: 5,
                              ),
                            ],
                          )),
                        ),

                        // ====================================================================
                        // ====================================================================
                        // ====================================================================

                        const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            " รอบที่ 2 รอบรับตรง",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )),
                        AdmissionInputFields(
                          specificSubject: _directSpecificSubject,
                          qty: _directQty,
                          detail: _directDetail,
                          status: _directStatus,
                          onStatusChanged: (value) {
                            setState(() {
                              _directStatus = value;
                            });
                          },
                          onSpecificSubjectChanged: (value) {
                            _directSpecificSubject = value;
                          },
                          onQtyChanged: (value) {
                            _directQty = value;
                          },
                          onDetailChanged: (value) {
                            _directDetail = value;
                          },
                        ),
                        // ====================================================================
                        // ====================================================================
                        // ====================================================================

                        // ====================================================================
                        // ====================================================================
                        // ====================================================================

                        const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            " รอบที่ 3 รอบความร่วมมือกับโรงเรียน",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )),
                        AdmissionInputFields(
                          specificSubject: _cooperationSpecificSubject,
                          qty: _cooperationQty,
                          detail: _cooperationDetail,
                          status: _cooperationStatus,
                          onStatusChanged: (value) {
                            setState(() {
                              _cooperationStatus = value;
                            });
                          },
                          onSpecificSubjectChanged: (value) {
                            _cooperationSpecificSubject = value;
                          },
                          onQtyChanged: (value) {
                            _cooperationQty = value;
                          },
                          onDetailChanged: (value) {
                            _cooperationDetail = value;
                          },
                        ),
                        // ====================================================================
                        // ====================================================================
                        // ====================================================================

                        const SizedBox(height: 20),
                        const Text(
                          'จำนวนหมู่เรียน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue:
                              _studyGroup.toString(), // convert to string
                          onChanged: (value) {
                            _studyGroup =
                                int.tryParse(value)!; // convert to int
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกจำนวนหมู่เรียน';
                            }
                            return null;
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: _deleteAdmissionPlan,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.delete),
                                  SizedBox(
                                      width:
                                          5), // Add some space between icon and text
                                  Text('ลบ'),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: _updateAdmissionPlan,
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

  TableRow _buildTableRow(String title, String content) {
    return TableRow(children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    ]);
  }
}

class AdmissionInputFields extends StatefulWidget {
  final String specificSubject;
  final int qty;
  final String detail;
  final bool status;
  final Function(bool) onStatusChanged;
  final Function(String) onSpecificSubjectChanged;
  final Function(int) onQtyChanged;
  final Function(String) onDetailChanged;

  AdmissionInputFields({
    required this.specificSubject,
    required this.qty,
    required this.detail,
    required this.status,
    required this.onStatusChanged,
    required this.onSpecificSubjectChanged,
    required this.onQtyChanged,
    required this.onDetailChanged,
  });

  @override
  _AdmissionInputFieldsState createState() => _AdmissionInputFieldsState();
}

class _AdmissionInputFieldsState extends State<AdmissionInputFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Table(
            children: [
              TableRow(
                children: [
                  const TableCell(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Text(
                        "สถานะ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Switch(
                      value: widget.status,
                      onChanged: widget.onStatusChanged,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.status,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'วิชาเฉพาะ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.specificSubject,
                onChanged: widget.onSpecificSubjectChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    widget.onSpecificSubjectChanged("-");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'จำนวนที่รับ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: widget.qty.toString(),
                onChanged: (value) {
                  widget.onQtyChanged(int.tryParse(value) ?? 0);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกจำนวนที่รับ';
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
                initialValue: widget.detail,
                onChanged: widget.onDetailChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรายละเอียด';
                  }
                  return null;
                },
                maxLines: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
