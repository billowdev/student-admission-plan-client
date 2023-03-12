import 'package:flutter/material.dart';

import '../edit_summary_quota_admission_plan_ui.dart';
import '../models/group_by_faculty_model.dart';

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
            'เรียนดี',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
          DataColumn(
              label: Text(
            'กิจกรรมดี\nกองพัฒฯ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
          DataColumn(
              label: Text(
            'กิจกรรมดี\nสถาบันภาษา',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
          DataColumn(
              label: Text(
            'กิจกรรมดี\nดนตรีสากล',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
          DataColumn(
              label: Text(
            'กีฬาดี',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
          DataColumn(
              label: Text(
            'คนดี',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
          DataColumn(
              label: Text(
            'รวม',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          )),
        ],
        rows: data.map((plan) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(plan.course.major)),
              DataCell(Text(plan.course.degree)),
              DataCell(Text("${plan.quotaGoodStudyQty}")),
              DataCell(Text("${plan.quotaGoodActivitySDDQty}")),
              DataCell(Text("${plan.quotaGoodActivityLIQty}")),
              DataCell(Text("${plan.quotaGoodActivityIMQty}")),
              DataCell(Text("${plan.quotaGoodSportQty}")),
              DataCell(Text("${plan.quotaGoodPersonQty}")),
              DataCell(Text(
                  "${plan.quotaGoodStudyQty + plan.quotaGoodActivitySDDQty + plan.quotaGoodActivityLIQty + plan.quotaGoodActivityIMQty + plan.quotaGoodSportQty + plan.quotaGoodPersonQty}")),
            ],
            selected: false,
            onSelectChanged: (isSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditSummaryQuotaAdmissionPlanDetailScreen(
                          admissionPlanId: plan.id,
                          yearFilter: plan.year,
                          degree: plan.course.degree,
                          faculty: plan.course.faculty,
                          facultyFilter: plan.course.faculty,
                          detail: plan,
                          major: plan.course.major,
                          year: yearFilter,
                        )),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
