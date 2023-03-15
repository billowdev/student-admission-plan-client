import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/admission_plan/widgets/group_by_faculty_ap_table.dart';
import '../../common/utils/local_storage_util.dart';

import 'package:http/http.dart' as http;

import 'models/exists_faculty_admission_plan_model.dart';
import 'models/group_by_faculty_model.dart';

class SummaryQuotaAdmissionPlan extends StatefulWidget {
  final String yearFilter;
  const SummaryQuotaAdmissionPlan({super.key, required this.yearFilter});

  @override
  State<SummaryQuotaAdmissionPlan> createState() =>
      _SummaryQuotaAdmissionPlanState();
}

class _SummaryQuotaAdmissionPlanState extends State<SummaryQuotaAdmissionPlan> {
  late String token = "";
  bool _isLoading = false;

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
    setState(() {
      _isLoading = true;
    });
    final url = Uri.http(BASEURL, '$ENDPOINT/ap/get-exists-faculty');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      ExistsFacultyAdmissionPlanModel existFaculty =
          ExistsFacultyAdmissionPlanModel.fromJson(jsonDecode(response.body));
      setState(() {
        existsFaculty = existFaculty.payload!;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  late Map<String, List<AdmissionPlan>> gropByFacultyAdmissionPlanData = {};

  _getAdmissionPlanGroupByFaculty() async {
    setState(() {
      _isLoading = true;
    });
    final queryParams = {'year': widget.yearFilter};
    final token = await LocalStorageUtil.getItem('token');
    final header = {
      'Authorization': 'Bearer ${token.toString()}',
      'Content-Type': 'application/json',
    };
    final url =
        Uri.http(BASEURL, '$ENDPOINT/ap/get-group-by-faculty', queryParams);
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      AdmissionPlanGroupByFacultyPayload groupByFacultyAdmissionPlan =
          AdmissionPlanGroupByFacultyPayload.fromJson(
              jsonDecode(response.body));
      setState(() {
        gropByFacultyAdmissionPlanData = groupByFacultyAdmissionPlan.payload;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Map<String, List<AdmissionPlan>> facultyPlans = {};
  Map<String, int> facultySums = {};
  int allSums = 0;

  @override
  void dispose() {
    gropByFacultyAdmissionPlanData.clear();
    facultyPlans.clear();
    facultySums.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(8.0)),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text:
                              "สรุปรอบโควตา ปี${widget.yearFilter.toString()}",
                          style: const TextStyle(
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ]);
  }
}
