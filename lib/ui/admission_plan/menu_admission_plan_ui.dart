import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/admission_plan/services/admission_plan_service.dart';
import './faculty/all_faculty_admission_plan_ui.dart';
import 'dart:core';

import '../../common/constants/constants.dart';

class AdmissionPlanMenuScreen extends StatefulWidget {
  const AdmissionPlanMenuScreen({super.key});

  @override
  State<AdmissionPlanMenuScreen> createState() =>
      _AdmissionPlanMenuScreenState();
}

class _AdmissionPlanMenuScreenState extends State<AdmissionPlanMenuScreen> {
  late String role = "";
  final AdmissionPlanService _admissionPlanService = AdmissionPlanService();
  final int currentYear = DateTime.now().year;
  String _selectedYear = "2565";

  // late List<String> _existsYear;
  late List<String> _yearList = List.generate(
      (currentYear + 543) - 2565, (index) => (2565 + index).toString());

  Future<List<String>> _getExistsYear() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/admission-plans/get-exists-year');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      List<int> yearList = List<int>.from(resp['payload']);
      List<String> stringList =
          yearList.map((year) => year.toString()).toList();
      _yearList.sort((a, b) => b.compareTo(a));
      _selectedYear = stringList[0];
      return stringList;
    } else {
      return [];
    }
  }

  void _loadYearList() async {
    _yearList = await _getExistsYear();
  }

  @override
  void dispose() {
    _yearList.clear();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadYearList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'แผนการรับนักศึกษาภาคปกติ'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(children: [
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
