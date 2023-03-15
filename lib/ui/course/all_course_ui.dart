import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/main_menu_ui.dart';
import 'package:project/ui/course/add_course_ui.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/search_bar.widget.dart';
import './models/course.model.dart';
import 'package:http/http.dart' as http;
import 'course_detail_ui.dart';

class AllCourseScreen extends StatefulWidget {
  const AllCourseScreen({super.key});

  @override
  State<AllCourseScreen> createState() => _AllCourseScreenState();
}

class _AllCourseScreenState extends State<AllCourseScreen> {
  late String token = "";
  List<CoursePayload> course = [];
  @override
  void initState() {
    super.initState();

    _getCourses();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
  }

  _getCourses() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/courses/get-all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      CourseModel courseData = CourseModel.fromJson(jsonDecode(response.body));
      setState(() {
        course = courseData.payload!;
      });
    }
  }

  _getCoursesKeyword(String? keyword) async {
    final queryParam = {"keyword": keyword};

    Uri url = Uri.http(BASEURL, '$ENDPOINT/courses/get-all', queryParam);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      CourseModel courseData = CourseModel.fromJson(jsonDecode(response.body));

      setState(() {
        course = courseData.payload!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(txtTitle: 'หน้าข้อมูลหลักสูตรทั้งหมด'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SearchBar(
                onTextChanged: (String value) {
                  if (value != "") {
                    _getCoursesKeyword(value);
                  } else {
                    _getCourses();
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
                          'สาขา',
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
                      'คณะ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      'หลักสูตร',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    )),
                  ],
                  rows: course.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text("${data.major}")),
                        DataCell(Text("${data.faculty}")),
                        DataCell(Text("${data.degree}")),
                      ],
                      selected: false, // Add this line to remove the borders
                      onSelectChanged: (isSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(
                                    detail: data,
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
                    visible: token.isNotEmpty,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainMenu()));
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
