import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/ui/admission_plan/faculty/edit_course_admission_plan_ui.dart';
import 'package:project/ui/extra_admission_plan/models/extra_admission_plan_array.dart';

import '../../../common/utils/local_storage_util.dart';
import '../../../common/widgets/appbar.widget.dart';
import '../../../common/widgets/drawer.widget.dart';
import 'edit_extra_admission_plan_course_ui.dart';

class ExtraAdmissionPlanCourse extends StatefulWidget {
  final ExtraAdmissionPlanArrayPayload detail;
  final String yearFilter;
  final String facultyFilter;
  final String major;
  final String degree;
  final String faculty;
  const ExtraAdmissionPlanCourse({
    super.key,
    required this.detail,
    required this.major,
    required this.degree,
    required this.faculty,
    required this.yearFilter,
    required this.facultyFilter,
  });
  @override
  State<ExtraAdmissionPlanCourse> createState() =>
      ExtraAdmissionPlanCourseState();
}

class ExtraAdmissionPlanCourseState extends State<ExtraAdmissionPlanCourse> {
  late String _major;
  late String _degree;
  late String _faculty;
  late int _qty;
  late String _year;
  late ExtraAdmissionPlanArrayPayload _allDetail;

  late String token = "";
  // final AuthService _authService = AuthService();
  // final TokenBloc _tokenBloc = TokenBloc(); // create an instance of TokenBloc
  @override
  void initState() {
    super.initState();
    setState(() {
      _allDetail = widget.detail;
      _year = widget.yearFilter;
      _qty = widget.detail.qty!;
      _major = widget.major;
      _degree = widget.degree;
      _faculty = widget.faculty;
    });

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
                        "แผนการรับนักศึกษา ภาคพิเศษ (กศ.ป.) \n ประจำปีการศึกษา ${_year.toString()}",
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
                        "รายละเอียด",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                    Table(
                      children: [
                        _buildTableRow('ปีการศึกษา', _year.toString()),
                        _buildTableRow('จำนวน', _qty.toString()),
                      ],
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
                            builder: (context) =>
                                EditExtraAdmissionPlanCourseScreen(
                              major: _major,
                              degree: _degree,
                              faculty: _faculty,
                              detail: _allDetail,
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
