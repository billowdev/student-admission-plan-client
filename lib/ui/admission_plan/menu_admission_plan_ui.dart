import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/admission_plan/services/admission_plan_service.dart';
import 'package:project/ui/admission_plan/summary_quota_admission_plan_ui.dart';
import './faculty/all_faculty_admission_plan_ui.dart';
import 'dart:core';

import '../../common/constants/constants.dart';

class AdmissionPlanMenuScreen extends StatefulWidget {
  final List<String> educationYearList;
  const AdmissionPlanMenuScreen({super.key, required this.educationYearList});

  @override
  State<AdmissionPlanMenuScreen> createState() =>
      _AdmissionPlanMenuScreenState();
}

class _AdmissionPlanMenuScreenState extends State<AdmissionPlanMenuScreen> {
  final int currentYear = DateTime.now().year;
  late List<String> _yearList = ["2565", "2566"];
  late String _selectedYear = "2565";

  // late List<String> _existsYear;
  // late List<String> _yearList = List.generate(
  //     (currentYear + 543) - 2565, (index) => (2565 + index).toString());

  _getExistsYear() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/admission-plans/get-exists-year');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      List<String> yearList = List<String>.from(resp['payload']);
      yearList.sort((a, b) => a.compareTo(b));
      setState(() {
        _selectedYear = "2565";
        _yearList = yearList;
      });
    }
  }

  @override
  void dispose() {
    _yearList.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
    _yearList = widget.educationYearList;
    _getExistsYear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'แผนการรับนักศึกษา'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              "แผนการรับนักศึกษา ภาคปกติ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )),
          const Padding(padding: EdgeInsets.all(8.0)),
          DropdownButtonFormField<String>(
            value: _selectedYear,
            items: _yearList.map((String year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(year),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedYear = value!;
              });
            },
            decoration: const InputDecoration(
              labelText: 'เลือกปีการศึกษา',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
          ),
          FacultyWidget(
              facultyName: 'สรุปรอบโควตา$_selectedYear',
              logoName: 'Logo.png',
              routeScreen: SummaryQuotaAdmissionPlan(
                yearFilter: _selectedYear,
              )),
          FacultyWidget(
              facultyName: 'คณะวิทยาศาสตร์และเทคโนโลยี',
              logoName: 'logo_sci.jpg',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะวิทยาศาสตร์และเทคโนโลยี',
                yearFilter: _selectedYear,
              )),
          FacultyWidget(
              facultyName: 'คณะมนุษยศาสตร์และสังคมศาสตร์',
              logoName: 'logo_lumanities.png',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะมนุษยศาสตร์และสังคมศาสตร์',
                yearFilter: _selectedYear,
              )),
          FacultyWidget(
              facultyName: 'คณะเทคโนโลยีอุตสาหกรรม',
              logoName: 'logo_industrial.png',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะเทคโนโลยีอุตสาหกรรม',
                yearFilter: _selectedYear,
              )),
          FacultyWidget(
              facultyName: 'คณะครุศาสตร์',
              logoName: 'logo_edu.png',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะครุศาสตร์',
                yearFilter: _selectedYear,
              )),
          FacultyWidget(
              facultyName: 'คณะเทคโนโลยีเกษตร ',
              logoName: 'logo_iacuc.jpg',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะเทคโนโลยีเกษตร ',
                yearFilter: _selectedYear,
              )),
          FacultyWidget(
              facultyName: 'คณะวิทยาการจัดการ ',
              logoName: 'logo_fms.jpg',
              routeScreen: AdmissionPlanFaculty(
                facultyFilter: 'คณะวิทยาการจัดการ ',
                yearFilter: _selectedYear,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
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
                  SizedBox(width: 5), // Add some space between icon and text
                  Text('กลับ'),
                ],
              ),
            ),
          )
        ]),
      ),
      drawer: const DrawerMenuWidget(),
    ));
  }
}

PreferredSizeWidget _appBarWideget() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Image.asset(
      'assets/images/Logo.png',
      fit: BoxFit.contain,
      // width: 50,
      // height: 50,
    ),
    title: const Text(
      'ระบบจัดการแผนการรับนักศึกษา',
      style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontFamily: 'PrintAble4U',
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    actions: [
      ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: const BorderSide(color: Colors.green, width: 1)),
          ),
          child: const Text('Login', style: TextStyle(color: Colors.green)))
    ],
  );
}

class FacultyWidget extends StatelessWidget {
  final String facultyName;
  final String logoName;
  final StatefulWidget routeScreen;
  const FacultyWidget(
      {super.key,
      required this.facultyName,
      required this.logoName,
      required this.routeScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: ListTile(
          leading: Image.asset(
            "assets/images/$logoName",
            height: 80,
            width: 80,
          ),
          title: Text(
            facultyName,
            // ignore: prefer_const_constructors
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => routeScreen),
            );
          },
        ),
      ),
    );
  }
}
