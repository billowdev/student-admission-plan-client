import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/course/add_course_ui.dart';
import '../../common/utils/local_storage_util.dart';
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
  late String token = "";

  @override
  void initState() {
    super.initState();

    _getCourses();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
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

  List<CoursePayload> course = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(txtTitle: 'หน้าข้อมูลหลักสูตรทั้งหมด'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
             SingleChildScrollView(scrollDirection: Axis.horizontal,child:  DataTable(
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
              ),),
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
                              builder: (context) => AddCourseScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          primary: Colors.white,
                        ),
                        child: Row(
                          children: [
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
                      backgroundColor: Colors.brown,
                      primary: Colors.white,
                    ),
                    child: Row(
                      children: [
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
        drawer: DrawerMenuWidget(),
      ),
    );
  }
}
