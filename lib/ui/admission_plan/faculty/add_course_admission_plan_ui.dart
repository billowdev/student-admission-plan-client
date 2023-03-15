import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/utils/local_storage_util.dart';
import 'package:project/common/widgets/confirm_button_widget.dart';
import '../../../common/widgets/appbar.widget.dart';
import '../../../common/widgets/drawer.widget.dart';
import '../../../common/widgets/search_bar.widget.dart';
import '../../course/models/course.model.dart';
import '../models/admission_plan_faculty_model.dart';
import 'all_faculty_admission_plan_ui.dart';
import 'edit_course_admission_plan_ui.dart';
import 'widgets/quota_admission_field.dart';

class AddAdmissionPlanScreen extends StatefulWidget {
  final AdmissionPlanFacultyPayload? admssionPlanData;
  final String? courseId;
  final String facultyFilter;

  const AddAdmissionPlanScreen(
      {super.key,
      required this.facultyFilter,
      this.admssionPlanData,
      this.courseId});

  @override
  _AddAdmissionPlanDetainState createState() => _AddAdmissionPlanDetainState();
}

class _AddAdmissionPlanDetainState extends State<AddAdmissionPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isNotSelectedCourse = true;

  // final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late String _major = "";
  late String _degree = "";
  late String _faculty = "";

  late String _year = "";
  late String _courseId = "";
  late bool _quotaStatus = false;

  late String _quotaSpecificSubject = "";
  late int _quotaGoodStudyQty = 0;
  late int _quotaGoodPersonQty = 0;
  late int _quotaGoodActivityIMQty = 0;
  late int _quotaGoodActivityLIQty = 0;
  late int _quotaGoodActivitySDDQty = 0;
  late int _quotaGoodSportQty = 0;

  late String _quotaDetail = "";
  // late int _sumQty;

  late bool _directStatus = false;
  late String _directSpecificSubject = "";
  late int _directQty = 0;
  late String _directDetail = "";

  late bool _cooperationStatus = false;
  late String _cooperationSpecificSubject = "";
  late int _cooperationQty = 0;
  late String _cooperationDetail = "";

  late int _studyGroup = 1;

  // late bool _quotaStatus;

  Map<String, String> courseData = {
    "major": "",
    "degree": "",
    "detail": "",
    "faculty": "",
  };
  late CourseDataPayload _course = CourseDataPayload(
      major: courseData['major'],
      degree: courseData['degree'],
      detail: courseData['detail'],
      faculty: courseData['faculty']);

  // get http => null;
  http.Client client = http.Client(); // create an instance of http client

  // final List<Map<String, String>> courses = [
  //   {
  //     "id": "2d28da7c-bb8f-4e41-bfe1-c6957641c1d0",
  //     "major": "สาขาวิชาเทคโนโลยีโยธา",
  //     "degree": "ทล.บ. 4 ปี",
  //     "faculty": "คณะเทคโนโลยีอุตสาหกรรม",
  //   },
  //   {
  //     "id": "2d28da7c-bb8f-4e41-bfe1-c6957641c1d1",
  //     "major": "สาขาวิชาสถาปัตยกรรม",
  //     "degree": "ทล.บ. 4 ปี",
  //     "faculty": "คณะเทคโนโลยีอุตสาหกรรม",
  //   },
  // ];

  late List<CoursePayload> _courses = [];

  _handleGetCourseById(String courseId) async {
    _isNotSelectedCourse = false;
    setState(() {
      _courseId = courseId;
    });
    final url = Uri.http(BASEURL, '$ENDPOINT/courses/get-one/$courseId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      CourseDataModel courseData =
          CourseDataModel.fromJson(jsonDecode(response.body));
      setState(() {
        _course = courseData.payload!;
      });
    }
  }

  _getCourses() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/courses/get-by-faculty/$_faculty');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      CourseModel courseData = CourseModel.fromJson(jsonDecode(response.body));
      setState(() {
        _courses = courseData.payload!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _faculty = widget.facultyFilter;
    _getCourses();

    if (widget.courseId != null) {
      _isNotSelectedCourse = false;
      _courseId = _courseId = widget.courseId!;
    } else {
      _courseId = "";
      _isNotSelectedCourse = true;
    }

    if (widget.admssionPlanData != null) {
      final admissionData = widget.admssionPlanData!;

      // Quota
      _quotaStatus = admissionData.quotaStatus ?? false;
      _studyGroup = admissionData.studyGroup ?? 1;

      _quotaSpecificSubject =
          admissionData.quotaSpecificSubject?.isEmpty ?? true
              ? '-'
              : admissionData.quotaSpecificSubject!;

      _quotaGoodStudyQty = admissionData.quotaGoodStudyQty ?? 0;
      _quotaGoodPersonQty = admissionData.quotaGoodPersonQty ?? 0;
      _quotaGoodActivityIMQty = admissionData.quotaGoodActivityIMQty ?? 0;
      _quotaGoodActivityLIQty = admissionData.quotaGoodActivityLIQty ?? 0;
      _quotaGoodActivitySDDQty = admissionData.quotaGoodActivitySDDQty ?? 0;
      _quotaGoodSportQty = admissionData.quotaGoodSportQty ?? 0;

      _quotaDetail = admissionData.quotaDetail?.isEmpty ?? true
          ? '-'
          : admissionData.quotaDetail!;

      // Direct
      _directStatus = admissionData.directStatus ?? false;
      _directSpecificSubject =
          admissionData.directSpecificSubject?.isEmpty ?? true
              ? '-'
              : admissionData.directSpecificSubject!;
      _directQty = admissionData.directQty ?? 0;
      _directDetail = admissionData.directDetail?.isEmpty ?? true
          ? '-'
          : admissionData.directDetail!;

      // Cooperation
      _cooperationStatus = admissionData.cooperationStatus ?? false;
      _cooperationSpecificSubject =
          admissionData.cooperationSpecificSubject?.isEmpty ?? true
              ? '-'
              : admissionData.cooperationSpecificSubject!;
      _cooperationQty = admissionData.cooperationQty ?? 0;
      _cooperationDetail = admissionData.cooperationDetail?.isEmpty ?? true
          ? '-'
          : admissionData.cooperationDetail!;

      _year = admissionData.year!;
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

  Future<void> _addAdmissionPlan() async {
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
          'quotaGoodStudyQty': _quotaGoodStudyQty,
          'quotaGoodPersonQty': _quotaGoodPersonQty,
          'quotaGoodActivityIMQty': _quotaGoodActivityIMQty,
          'quotaGoodActivityLIQty': _quotaGoodActivityLIQty,
          'quotaGoodActivitySDDQty': _quotaGoodActivitySDDQty,
          'quotaGoodSportQty': _quotaGoodSportQty,
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
          'courseId': _courseId
        };

        final url = Uri.http(BASEURL, "$ENDPOINT/admission-plans/create");
          final token = await LocalStorageUtil.getItem('token');
        final header = {
          'Authorization': 'Bearer ${token.toString()}',
          'Content-Type': 'application/json',
        };

        final response =
            await client.post(url, headers: header, body: jsonEncode(fdata));
        if (response.statusCode == 201) {
          _showSnackBar('เพิ่มข้อมูลสำเร็จ', Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdmissionPlanFaculty(
                      facultyFilter: _faculty,
                      yearFilter: _year,
                    )),
          );
        } else {
          if (jsonDecode(response.body)['message'].toString().split(" ")[0] ==
              'courseId') {
            _showSnackBar(
                'เพิ่มข้อมูลไม่สำเร็จ กรุณาเลือกหลักสูตร', Colors.red);
          }

          if (response.statusCode == 409) {
            _showSnackBar(
                'ปีการศึกษาซ้ำในระบบ กรุณากรอกปีการศึกษาใหม่', Colors.red);
          }
        }
      } catch (e) {
        _showSnackBar('เพิ่มข้อมูลไม่สำเร็จ ระบบขัดข้อง', Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'เพิ่มข้อมูลแผนการรับนักศึกษา'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "สำหรับหลักสูตร",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )),
                        // is not selected course then show pop up
                        // Visibility(
                        //     visible: _isNotSelectedCourse,
                        //     child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [

                        //         ])),
                        Center(
                          child: ElevatedButton(
                            child: const Text('เลือกข้อมูลหลักสูตร'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () async {
                              final result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MyCoursePopUp(
                                    courses: _courses,
                                    facultyFilter: widget.facultyFilter,
                                    onCourseSelected: (courseId) => {
                                      _handleGetCourseById(courseId),
                                      _courseId = courseId
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Visibility(
                            visible: !_isNotSelectedCourse,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Table(
                                    children: [
                                      _buildTableRow('ชื่อหลักสูตร',
                                          _course.major.toString()),
                                      _buildTableRow('หลักสูตร',
                                          _course.degree.toString()),
                                      _buildTableRow(
                                          'คณะ', _course.faculty.toString()),
                                    ],
                                  ),
                                ])),
                        // Center(
                        //     child: Padding(
                        //   padding: const EdgeInsets.all(8),
                        //   child: Text(
                        //     "แผนการรับนักศึกษาประจำปีการศึกษา ${_year.toString()}",
                        //     style: const TextStyle(
                        //         fontWeight: FontWeight.bold, fontSize: 18),
                        //   ),
                        // )),
                        // Table(
                        //   children: [
                        //     _buildTableRow('ชื่อหลักสูตร', _major.toString()),
                        //     _buildTableRow('หลักสูตร', _degree.toString()),
                        //     _buildTableRow('คณะ', _faculty.toString()),
                        //   ],
                        // ),

                        const SizedBox(height: 20),
                        const Text(
                          'ปีการศึกษา',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _year.toString(),
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

                        QuotaAdmissionInputFields(
                          specificSubject: _quotaSpecificSubject,
                          quotaGoodStudyQty: _quotaGoodStudyQty,
                          quotaGoodPersonQty: _quotaGoodPersonQty,
                          quotaGoodActivityIMQty: _quotaGoodActivityIMQty,
                          quotaGoodActivityLIQty: _quotaGoodActivityLIQty,
                          quotaGoodActivitySDDQty: _quotaGoodActivitySDDQty,
                          quotaGoodSportQty: _quotaGoodSportQty,
                          detail: _quotaDetail,
                          status: _quotaStatus,
                          onStatusChanged: (value) {
                            setState(() {
                              _quotaStatus = value;
                            });
                          },
                          onSpecificSubjectChanged: (value) {
                            _quotaSpecificSubject = value;
                          },
                          onQuotaGoodStudyQtyChanged: (value) {
                            _quotaGoodStudyQty = value;
                          },
                          onQuotaGoodPersonQtyChanged: (value) {
                            _quotaGoodPersonQty = value;
                          },
                          onQuotaGoodActivityIMQtyChanged: (value) {
                            _quotaGoodActivityIMQty = value;
                          },
                          onQuotaGoodActivityLIQtyChanged: (value) {
                            _quotaGoodActivityLIQty = value;
                          },
                          onQuotaGoodActivitySDDQtyChanged: (value) {
                            _quotaGoodActivitySDDQty = value;
                          },
                          onQuotaGoodSportQtyChanged: (value) {
                            _quotaGoodSportQty = value;
                          },
                          onDetailChanged: (value) {
                            _quotaDetail = value;
                          },
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
                            ConfirmDialog(
                              title: 'เพิ่มข้อมูล ?',
                              description: 'คุณต้องการเพิ่มข้อมูลใช่หรือไม่',
                              onNo: () => {Navigator.of(context).pop()},
                              onYes: _addAdmissionPlan,
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

class MyCoursePopUp extends StatefulWidget {
  final List<CoursePayload> courses;
  final String facultyFilter;
  final Function(String)? onCourseSelected;
  MyCoursePopUp(
      {required this.courses,
      this.onCourseSelected,
      required this.facultyFilter});

  @override
  _MyCoursePopUpState createState() => _MyCoursePopUpState();
}

class _MyCoursePopUpState extends State<MyCoursePopUp> {
  String? _selectedItemId;
  late List<CoursePayload> _courses = [];
  late String _faculty;
  @override
  void initState() {
    super.initState();
    setState(() {
      _courses = widget.courses;
      _faculty = widget.facultyFilter;
    });
  }

  _getCourses() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/courses/get-by-faculty/$_faculty');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      CourseModel courseData = CourseModel.fromJson(jsonDecode(response.body));

      setState(() {
        _courses = courseData.payload!;
      });
    } else {
      _courses = [];
    }
  }

  _getCoursesKeyword(String? keyword) async {
    Uri url = Uri.http(BASEURL, '$ENDPOINT/courses/get-by-faculty/$_faculty');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      CourseModel courseData = CourseModel.fromJson(jsonDecode(response.body));

      setState(() {
        _courses = courseData.payload!;
      });
    } else {
      _courses = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'เลือกข้อมูลหลักสูตร',
        style: TextStyle(color: Colors.green),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(
              onTextChanged: (String value) {
                if (value != "") {
                  setState(() {
                    _courses = _getCoursesKeyword(value);
                  });
                } else {
                  setState(() {
                    _courses = _getCourses() as List<CoursePayload>;
                  });
                }
              },
            ),
            ListBody(
              children: _courses.map((course) {
                return GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(), // add a line before the Padding widget
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "${course.major!} (${course.degree!})",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Divider(), // add a line after the Padding widget
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _selectedItemId = course.id;
                    });
                    widget.onCourseSelected?.call(course.id!);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('ยกเลิก'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
