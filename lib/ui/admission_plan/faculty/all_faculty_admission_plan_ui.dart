import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/admission_plan/faculty/add_course_admission_plan_ui.dart';
import 'package:project/ui/course/add_course_ui.dart';
import '../../../common/constants/constants.dart';
import '../../../common/utils/local_storage_util.dart';
import '../models/admission_plan_faculty_model.dart';
import 'package:http/http.dart' as http;

import 'course_admission_plan_ui.dart';

class AdmissionPlanFaculty extends StatefulWidget {
  final String facultyFilter;
  final String yearFilter;
  const AdmissionPlanFaculty(
      {super.key, required this.facultyFilter, required this.yearFilter});
  @override
  State<AdmissionPlanFaculty> createState() => _AdmissionPlanFacultyState();
}

class _AdmissionPlanFacultyState extends State<AdmissionPlanFaculty> {
  List<AdmissionPlanFacultyPayload> admssionPlanData = [];

  late String _facultyFilter = widget.facultyFilter;
  late String _yearFilter;
  late String token = "";

  @override
  void initState() {
    super.initState();
    _facultyFilter = widget.facultyFilter.toString();
    _yearFilter = widget.yearFilter.toString();
    _getAdmissionPlan();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
  }

  @override
  void dispose() {
    admssionPlanData.clear();
    super.dispose();
  }

  _getAdmissionPlan() async {
    var queryParam = {"year": widget.yearFilter.toString()};
    // var urlNews = Uri.http('localhost:5000', '/c/get-all', queryParam);
    final url = Uri.http(
        BASEURL,
        '$ENDPOINT/admission-plans/get-by-faculty/${widget.facultyFilter.toString()}',
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(txtTitle: 'แผนการรับนักศึกษา'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  "แผนการรับนักศึกษา ภาคปกติ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "$_facultyFilter\n ประจำปีการศึกษา $_yearFilter",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showCheckboxColumn: false,
                  sortAscending: true,
                  columns: const <DataColumn>[
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
                  ],
                  rows: admssionPlanData.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text("${data.course?.major}")),
                        DataCell(Text("${data.course?.degree}")),
                        DataCell(Text("${data.year}")),
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
                                    facultyFilter: widget.facultyFilter,
                                    yearFilter: widget.yearFilter,
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
                              builder: (context) => AddAdmissionPlanScreen(
                                facultyFilter: _facultyFilter,
                              ),
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
