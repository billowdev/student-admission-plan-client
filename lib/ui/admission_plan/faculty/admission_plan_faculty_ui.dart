import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/common/widgets/search_bar.widget.dart';
import 'package:project/ui/course/add_course_ui.dart';
import '../../../common/utils/local_storage_util.dart';
import '../models/admission_plan_faculty_model.dart';
import '../models/admission_plan_model.dart';
import 'package:http/http.dart' as http;

import 'admission_plan_course_ui.dart';

class AdmissionPlanFaculty extends StatefulWidget {
  final String facultyFilter;
  final String yearFilter;
  const AdmissionPlanFaculty(
      {super.key, required this.facultyFilter, required this.yearFilter});
  @override
  State<AdmissionPlanFaculty> createState() => _AdmissionPlanFacultyState();
}

class _AdmissionPlanFacultyState extends State<AdmissionPlanFaculty> {
  static String apiUrl = dotenv.env['API_URL'].toString();
  late String token = "";
  String dropdownValue = 'Option 1'; // initial value of the dropdown
  @override
  void initState() {
    super.initState();
    _getAdmissionPlan();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
  }

  _getAdmissionPlan() async {
    var queryParam = {"year": widget.yearFilter.toString()};
    // var urlNews = Uri.http('localhost:5000', '/c/get-all', queryParam);
    final url = Uri.http(
        apiUrl,
        '/admission-plans/get-by-faculty/${widget.facultyFilter.toString()}',
        queryParam);

    // final url = Uri.http('localhost:5000', '/courses/get-all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      AdmssionPlanFacultyModel resp =
          AdmssionPlanFacultyModel.fromJson(jsonDecode(response.body));

      setState(() {
        admssionPlanData = resp.payload!;
      });
    }
  }

  // _searchAdmissionPlan(String keyword) async {
  //   var queryParam = {"year": widget.yearFilter.toString(), "keyword": keyword};
  //   var urlNews = Uri.http('localhost:5000', '/c/get-all', queryParam);
  //   final url = Uri.http(apiUrl,
  //       '/ap/get-by-faculty/${widget.facultyFilter.toString()}', queryParam);
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     AdmssionPlanFacultyModel resp =
  //         AdmssionPlanFacultyModel.fromJson(jsonDecode(response.body));
  //     setState(() {
  //       admssionPlanData = resp.payload!;
  //     });
  //   }
  // }

  List<AdmssionPlanFacultyPayload> admssionPlanData = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(txtTitle: 'แผนการรับนักศึกษา'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // SearchBar(onTextChanged: (value) {
              //   if (value != "") {
              //     _searchAdmissionPlan(value);
              //   } else {
              //     _getAdmissionPlan();
              //   }
              // }),
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
                          'ปีการศึกษา',
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
                      'สาขาวิชา',
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
                  rows: admssionPlanData.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text("${data.year}")),
                        DataCell(Text("${data.course?.major}")),
                        DataCell(Text("${data.course?.degree}")),
                      ],
                      selected: false, // Add this line to remove the borders
                      onSelectChanged: (isSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdmissionPlanFacultyDetail(
                                    detail: data,
                                    major: "${data.course?.major}",
                                    degree: "${data.course?.degree}",
                                    faculty: "${data.course?.faculty}",
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
