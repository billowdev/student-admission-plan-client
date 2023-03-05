import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import './models/course.model.dart';
import 'package:http/http.dart' as http;

import 'course_detail_ui.dart';

class AllCourseScreen extends StatefulWidget {
  const AllCourseScreen({super.key});

  @override
  State<AllCourseScreen> createState() => _AllCourseScreenState();
}

class _AllCourseScreenState extends State<AllCourseScreen> {
  static String apiUrl = dotenv.env['API_URL'].toString();

  @override
  void initState() {
    super.initState();
    _getCourses();
  }

  List<CoursePayload> course = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(txtTitle: 'หน้าข้อมูลหลักสูตรทั้งหมด'),
        body: SingleChildScrollView(
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
        drawer: DrawerMenuWidget(),
      ),
    );
  }

  _getCourses() async {
    // var queryParam = {"major": "science"};
    // var urlNews = Uri.http('localhost:5000', '/c/get-all', queryParam);
    final url = Uri.http(apiUrl, '/courses/get-all');

    // final url = Uri.http('localhost:5000', '/courses/get-all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      CourseModel courseData = CourseModel.fromJson(jsonDecode(response.body));
      setState(() {
        course = courseData.payload!;
      });
    }
  }
}
