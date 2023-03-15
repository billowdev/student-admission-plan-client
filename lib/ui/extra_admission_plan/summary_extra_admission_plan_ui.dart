import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/course/add_course_ui.dart';
import 'package:project/ui/extra_admission_plan/extra_admission_plan_course_ui.dart';
import 'package:project/ui/extra_admission_plan/models/exists_faculty_extra_admission_plan_model.dart';
import 'package:project/ui/extra_admission_plan/models/summary_extra_admission_plan_model.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/search_bar.widget.dart';

import 'package:http/http.dart' as http;

import '../course/course_detail_ui.dart';

class SummaryExtraAdmissionPlan extends StatefulWidget {
  final yearFilter;
  const SummaryExtraAdmissionPlan({super.key, this.yearFilter});

  @override
  State<SummaryExtraAdmissionPlan> createState() =>
      _SummaryExtraAdmissionPlanState();
}

class _SummaryExtraAdmissionPlanState extends State<SummaryExtraAdmissionPlan> {
  late String token = "";
  late List<String> existsFaculty = [
    "คณะวิทยาศาสตร์และเทคโนโลยี",
    "คณะมนุษยศาสตร์และสังคมศาสตร์",
    "คณะเทคโนโลยีอุตสาหกรรม",
    "คณะครุศาสตร์",
    "คณะเทคโนโลยีเกษตร",
    "คณะวิทยาการจัดการ",
  ];
  late Map<String, List<ExtraAdmissionPlan>> extraAdmissionPlanData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _getExistsFacultyExtraAdmissionPlan();
    _getExtraAdmissionPlanGroupByFaculty();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
  }

  _getExistsFacultyExtraAdmissionPlan() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.http(BASEURL, '$ENDPOINT/eap/get-exists-faculty');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      ExistsFacultyExtraAdmissionPlan existFaculty =
          ExistsFacultyExtraAdmissionPlan.fromJson(jsonDecode(response.body));
      setState(() {
        existsFaculty = existFaculty.payload!;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  _getExtraAdmissionPlanGroupByFaculty() async {
    setState(() {
      _isLoading = true;
    });
    var queryParams = {'year': widget.yearFilter};
    final url =
        Uri.http(BASEURL, '$ENDPOINT/eap/get-group-by-faculty', queryParams);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      ExtraAdmissionPlanGroupByFacultyPayload extraAdmissionPlan =
          ExtraAdmissionPlanGroupByFacultyPayload.fromJson(
              jsonDecode(response.body));

      setState(() {
        extraAdmissionPlanData = extraAdmissionPlan.payload;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Map<String, List<ExtraAdmissionPlan>> facultyPlans = {};
  Map<String, int> facultySums = {};
  int allSums = 0;

  @override
  void dispose() {
    extraAdmissionPlanData.clear();
    facultyPlans.clear();
    facultySums.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    extraAdmissionPlanData.forEach((faculty, plans) {
      facultyPlans[faculty] = plans;
      facultySums[faculty] = plans.fold<int>(0, (sum, plan) => sum + plan.qty);
      allSums += facultySums[faculty]!;
    });

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(txtTitle: 'สรุปแผนการรับนักศึกษา'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Center(
                        child: RichText(
                          text: const TextSpan(
                            text: "จำนวนที่รับนักศึกษาภาคพิเศษ (กศ.ป.)",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontFamily: 'PrintAble4U',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "ปีการศึกษา ${widget.yearFilter}",
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontFamily: 'PrintAble4U',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      //=============================
                      Column(
                        children: existsFaculty.map((faculty) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: faculty,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'PrintAble4U',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              ExtraAdmissionPlanTable(
                                data: facultyPlans[faculty] ?? [],
                                yearFilter: widget.yearFilter,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Table(
                                    children: [
                                      _buildTableRow('$faculty รวม :',
                                          facultySums[faculty].toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Table(
                            children: [
                              _buildTableRow(
                                  'สรุปรวมทุกคณะ', allSums.toString()),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                                    width:
                                        5), // Add some space between icon and text
                                Text('กลับ'),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
          ),
        ),
        drawer: const DrawerMenuWidget(),
      ),
    );
  }

  TableRow _buildTableRow(String title, String content) {
    return TableRow(children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Text(
            content,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ]);
  }
}

class ExtraAdmissionPlanTable extends StatelessWidget {
  final List<ExtraAdmissionPlan> data;
  final String yearFilter;

  ExtraAdmissionPlanTable({required this.data, required this.yearFilter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            'หลักสูตร',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
          DataColumn(
              label: Text(
            'จำนวนที่รับ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
        ],
        rows: data.map((data) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(data.course.major)),
              DataCell(Text(data.course.degree)),
              DataCell(Text("${data.qty}")),
            ],
            selected: false,
            onSelectChanged: (isSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExtraAdmissionPlanCourse(
                          eapId: data.id,
                          qty: data.qty,
                          yearFilter: data.year,
                          degree: data.course.degree,
                          detail: data.course.detail,
                          faculty: data.course.faculty,
                          facultyFilter: data.course.faculty,
                          major: data.course.major,
                        )),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
