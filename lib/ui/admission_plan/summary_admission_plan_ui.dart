import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import '../../common/utils/local_storage_util.dart';

import 'package:http/http.dart' as http;

import 'models/exists_faculty_admission_plan_model.dart';
import 'models/group_by_faculty_model.dart';

class SummaryAdmissionPlan extends StatefulWidget {
  final yearFilter;
  const SummaryAdmissionPlan({super.key, this.yearFilter});

  @override
  State<SummaryAdmissionPlan> createState() => _SummaryAdmissionPlanState();
}

class _SummaryAdmissionPlanState extends State<SummaryAdmissionPlan> {
  late String token = "";
  late List<String> existsFaculty = [
    "คณะวิทยาศาสตร์และเทคโนโลยี",
    "คณะมนุษยศาสตร์และสังคมศาสตร์",
    "คณะเทคโนโลยีอุตสาหกรรม",
    "คณะครุศาสตร์",
    "คณะเทคโนโลยีเกษตร",
    "คณะวิทยาการจัดการ",
  ];

  @override
  void initState() {
    super.initState();

    _getExistsFacultyAdmissionPlan();
    _getAdmissionPlanGroupByFaculty();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
  }

  _getExistsFacultyAdmissionPlan() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/ap/get-exists-faculty');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      ExistsFacultyAdmissionPlanModel existFaculty =
          ExistsFacultyAdmissionPlanModel.fromJson(jsonDecode(response.body));
      setState(() {
        existsFaculty = existFaculty.payload!;
      });
    }
  }

  late Map<String, List<AdmissionPlan>> gropByFacultyAdmissionPlanData = {};

  _getAdmissionPlanGroupByFaculty() async {
    var queryParams = {'year': widget.yearFilter};
    final url =
        Uri.http(BASEURL, '$ENDPOINT/ap/get-group-by-faculty', queryParams);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      AdmissionPlanGroupByFacultyPayload groupByFacultyAdmissionPlan =
          AdmissionPlanGroupByFacultyPayload.fromJson(
              jsonDecode(response.body));
      setState(() {
        gropByFacultyAdmissionPlanData = groupByFacultyAdmissionPlan.payload;
      });
    }
  }

  Map<String, List<AdmissionPlan>> facultyPlans = {};
  Map<String, int> facultySums = {};
  int allSums = 0;

  @override
  Widget build(BuildContext context) {
    // gropByFacultyAdmissionPlanData.forEach((faculty, plans) {
    //   facultyPlans[faculty] = plans;

    //   int? facultySum = plans.fold<int?>(
    //     null,
    //     (sum, plan) =>
    //         (sum ?? 0) +
    //         plan.quotaGoodStudyQty! +
    //         plan.quotaGoodPersonQty! +
    //         plan.quotaGoodSportQty! +
    //         plan.quotaGoodActivityIMQty! +
    //         plan.quotaGoodActivityLIQty! +
    //         plan.quotaGoodActivitySDDQty!,
    //   );
    //   if (facultySum != null) {
    //     facultySums[faculty] = facultySum;
    //     allSums += facultySum;
    //   }
    // });
    gropByFacultyAdmissionPlanData.forEach((faculty, plans) {
      facultyPlans[faculty] = plans;
      facultySums[faculty] = plans.fold<int>(
          0,
          (sum, plan) =>
              sum +
              plan.quotaGoodActivityIMQty +
              plan.quotaGoodActivityLIQty +
              plan.quotaGoodActivitySDDQty +
              plan.quotaGoodPersonQty +
              plan.quotaGoodSportQty +
              plan.quotaGoodStudyQty);
      allSums += facultySums[faculty]!;
    });
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(txtTitle: 'สรุปแผนการรับนักศึกษา'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                      gropByFacultyAdmissionPlanTable(
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
                      _buildTableRow('สรุปรวมทุกคณะ', allSums.toString()),
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

class gropByFacultyAdmissionPlanTable extends StatelessWidget {
  final List<AdmissionPlan> data;
  final String yearFilter;

  gropByFacultyAdmissionPlanTable(
      {required this.data, required this.yearFilter});

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
              DataCell(Text("${data.quotaGoodStudyQty}")),
            ],
            selected: false,
            onSelectChanged: (isSelected) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => gropByFacultyAdmissionPlanCourse(
              //             eapId: data.id,
              //             qty: data.qty,
              //             yearFilter: data.year,
              //             degree: data.course.degree,
              //             detail: data.course.detail,
              //             faculty: data.course.faculty,
              //             facultyFilter: data.course.faculty,
              //             major: data.course.major,
              //           )),
              // );
            },
          );
        }).toList(),
      ),
    );
  }
}
