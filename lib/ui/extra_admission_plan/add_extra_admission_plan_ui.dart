import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/utils/local_storage_util.dart';
import 'package:project/common/widgets/confirm_button_widget.dart';
import 'package:project/ui/extra_admission_plan/extra_admission_plan_faculty_ui.dart';
import 'package:project/ui/extra_admission_plan/models/extra_admission_plan_array.dart';
import '../../../common/widgets/appbar.widget.dart';
import '../../../common/widgets/drawer.widget.dart';
import '../../../common/widgets/search_bar.widget.dart';
import '../course/models/course.model.dart';

class AddExtraAdmissionPlanScreen extends StatefulWidget {
  final ExtraAdmissionPlanArrayPayload? extraAdmssionPlanData;
  final String? courseId;
  final String facultyFilter;

  const AddExtraAdmissionPlanScreen(
      {super.key,
      required this.facultyFilter,
      this.extraAdmssionPlanData,
      this.courseId});

  @override
  _AddAdmissionPlanDetainState createState() => _AddAdmissionPlanDetainState();
}

class _AddAdmissionPlanDetainState extends State<AddExtraAdmissionPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isNotSelectedCourse = true;

  // final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late String _major = "";
  late String _degree = "";
  late String _faculty = "";

  late String _courseId = "";

  late String _year = "";

  late int _qty = 1;

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

    if (widget.extraAdmssionPlanData != null) {
      final extraAdmissionData = widget.extraAdmssionPlanData!;

      // Quota

      _qty = extraAdmissionData.qty ?? 1;

      _year = extraAdmissionData.year!;
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
        final fdata = {'qty': _qty, 'year': _year, 'courseId': _courseId};
        final token = await LocalStorageUtil.getItem('token');
        final header = {
          'Authorization': 'Bearer ${token.toString()}',
          'Content-Type': 'application/json',
        };
        final url = Uri.http(BASEURL, "$ENDPOINT/eap/create");
        final response =
            await client.post(url, headers: header, body: jsonEncode(fdata));
        if (response.statusCode == 201) {
          _showSnackBar('เพิ่มข้อมูลสำเร็จ', Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExtraAdmissionPlanFaculty(
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
                        const SizedBox(height: 20),
                        const Text(
                          'จำนวนที่รับ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          initialValue: _qty.toString(),
                          onChanged: (value) {
                            _qty = int.tryParse(value)!;
                            ;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกจำนวนที่รับ';
                            }
                            return null;
                          },
                        ),
                        // ====================================================================
                        // ====================================================================
                        // ====================================================================

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
