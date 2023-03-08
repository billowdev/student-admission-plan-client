import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/ui/admission_plan/faculty/admission_plan_edit_detail_ui.dart';

import '../../../common/utils/local_storage_util.dart';
import '../../../common/widgets/appbar.widget.dart';
import '../../../common/widgets/drawer.widget.dart';
import '../models/admission_plan_faculty_model.dart';

class AdmissionPlanFacultyDetail extends StatefulWidget {
  final AdmissionPlanFacultyPayload detail;
  final String yearFilter;
  final String facultyFilter;
  final String major;
  final String degree;
  final String faculty;
  const AdmissionPlanFacultyDetail({
    super.key,
    required this.detail,
    required this.major,
    required this.degree,
    required this.faculty,
    required this.yearFilter,
    required this.facultyFilter,
  });
  @override
  State<AdmissionPlanFacultyDetail> createState() =>
      AdmissionPlanFacultyDetailState();
}

class AdmissionPlanFacultyDetailState
    extends State<AdmissionPlanFacultyDetail> {
  late String _quotaStatus;
  late String _quotaSpecificSubject;
  late int _quotaQty;
  late String _quotaDetail;
  late int _sumQty;
  late String _directStatus;
  late String _directSpecificSubject;
  late int _directQty;
  late String _directDetail;

  late String _cooperationStatus;
  late String _cooperationSpecificSubject;
  late int _cooperationQty;
  late String _cooperationDetail;

  late int _year;
  late int _studyGroup;

  late String _major;
  late String _degree;
  late String _faculty;
  late AdmissionPlanFacultyPayload _allDetail;
  late String _id;

  late String token = "";
  // final AuthService _authService = AuthService();
  // final TokenBloc _tokenBloc = TokenBloc(); // create an instance of TokenBloc
  @override
  void initState() {
    super.initState();
    _allDetail = widget.detail;
    _id = widget.detail.id!;
    // _major = widget.detail.major!;
    // ========================== quota ==========================
    if (widget.detail.quotaStatus == true) {
      _quotaStatus = "รับ";
    } else {
      _quotaStatus = "ไม่รับ";
    }
    if (widget.detail.quotaSpecificSubject == "") {
      _quotaSpecificSubject = "-";
    } else {
      _quotaSpecificSubject = widget.detail.quotaSpecificSubject!;
    }

    if (widget.detail.quotaQty != 0) {
      _quotaQty = widget.detail.quotaQty!;
    } else {
      _quotaQty = 0;
    }

    if (widget.detail.quotaDetail != "") {
      _quotaDetail = widget.detail.quotaDetail!;
    } else {
      _quotaDetail = "-";
    }

    // ========================== direct ==========================
    if (widget.detail.directStatus == true) {
      _directStatus = "รับ";
    } else {
      _directStatus = "ไม่รับ";
    }
    if (widget.detail.directSpecificSubject == "") {
      _directSpecificSubject = "-";
    } else {
      _directSpecificSubject = widget.detail.directSpecificSubject!;
    }

    if (widget.detail.directQty != 0) {
      _directQty = widget.detail.directQty!;
    } else {
      _directQty = 0;
    }
    if (widget.detail.directDetail != "") {
      _directDetail = widget.detail.directDetail!;
    } else {
      _directDetail = "-";
    }

    // ========================== cooperation ==========================
    if (widget.detail.cooperationStatus == true) {
      _cooperationStatus = "รับ";
    } else {
      _cooperationStatus = "ไม่รับ";
    }

    if (widget.detail.cooperationSpecificSubject == "") {
      _cooperationSpecificSubject = "-";
    } else {
      _cooperationSpecificSubject = widget.detail.cooperationSpecificSubject!;
    }

    if (widget.detail.cooperationQty != 0) {
      _cooperationQty = widget.detail.cooperationQty!;
    } else {
      _cooperationQty = 0;
    }
    if (widget.detail.cooperationDetail != "") {
      _cooperationDetail = widget.detail.cooperationDetail!;
    } else {
      _cooperationDetail = "-";
    }

    _year = widget.detail.year!;
    // if (widget.detail.year != "") {
    // _year = widget.detail.year!;
    // } else {
    //   _year = 0;
    // }

    _studyGroup = widget.detail.studyGroup!;
    _major = widget.major;

    // if (widget.major != null) {
    // } else {
    //   _major = "";
    // }
    _degree = widget.degree;
    _faculty = widget.faculty;

    _sumQty = _quotaQty + _cooperationQty + _directQty;

    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'รายละเอียดแผนการรับนักศึกษา'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "แผนการรับนักศึกษาประจำปีการศึกษา ${_year.toString()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                    Table(
                      children: [
                        _buildTableRow('ชื่อหลักสูตร', _major.toString()),
                        _buildTableRow('หลักสูตร', _degree.toString()),
                        _buildTableRow('คณะ', _faculty.toString()),
                      ],
                    ),
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "รอบที่ 1 รอบโควตา",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                    Table(
                      children: [
                        _buildTableRow('สถานะ', _quotaStatus.toString()),
                        _buildTableRow(
                            'วิชาเฉพาะ', _quotaSpecificSubject.toString()),
                        _buildTableRow('จำนวนที่รับ', _quotaQty.toString()),
                        _buildTableRow('รายละเอียด', _quotaDetail.toString()),
                      ],
                    ),
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "รอบที่ 2 รอบรับตรง",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                    Table(
                      children: [
                        _buildTableRow('สถานะ', _directStatus.toString()),
                        _buildTableRow(
                            'วิชาเฉพาะ', _directSpecificSubject.toString()),
                        _buildTableRow('จำนวนที่รับ', _directQty.toString()),
                        _buildTableRow('รายละเอียด', _directDetail.toString()),
                      ],
                    ),
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "รอบที่ 3 ความร่วมมือกับ รร.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                    Table(
                      children: [
                        _buildTableRow('สถานะ', _cooperationStatus.toString()),
                        _buildTableRow('วิชาเฉพาะ',
                            _cooperationSpecificSubject.toString()),
                        _buildTableRow(
                            'จำนวนที่รับ', _cooperationQty.toString()),
                        _buildTableRow(
                            'รายละเอียด', _cooperationDetail.toString()),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Table(
                      children: [
                        _buildTableRow(
                            'จำนวนหมู่เรียน', _studyGroup.toString()),
                        _buildTableRow('จำนวนที่รับทั้งหมด', _sumQty.toString())
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                    ),
                  ],
                )),
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
                            builder: (context) => EditAdmissionPlanDetailScreen(
                              detail: _allDetail,
                              major: _major,
                              degree: _degree,
                              faculty: _faculty,
                              year: _year,
                              admissionPlanId: _id,
                              facultyFilter: widget.facultyFilter,
                              yearFilter: widget.yearFilter,
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
                          Icon(Icons.edit),
                          SizedBox(
                              width: 5), // Add some space between icon and text
                          Text('แก้ไข'),
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
                      Icon(Icons.arrow_back_ios_new_sharp),
                      SizedBox(
                          width: 5), // Add some space between icon and text
                      Text('กลับ'),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8),
            ),
          ],
        ),
      ),
      drawer: const DrawerMenuWidget(),
    ));
  }

  TableRow _buildTableRow(String title, String content) {
    return TableRow(children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    ]);
  }
}
