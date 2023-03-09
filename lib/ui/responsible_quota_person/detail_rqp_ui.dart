import 'package:flutter/material.dart';
import 'package:project/ui/course/models/course.model.dart';
import 'package:project/ui/responsible_quota_person/models/rqp_model.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';
import 'edit_rqp_ui.dart';

class DetailRQPScreen extends StatefulWidget {
  final String id;
  final String year;
  final String name;
  final String surname;
  final String agency;
  final String phone;
  final String quota;
  const DetailRQPScreen(
      {super.key,
      required this.year,
      required this.name,
      required this.surname,
      required this.agency,
      required this.phone,
      required this.quota,
      required this.id});
  @override
  State<DetailRQPScreen> createState() => _DetailRQPScreenState();
}

class _DetailRQPScreenState extends State<DetailRQPScreen> {
  late String token = "";
  late String _year;
  late String _name;
  late String _id;
  late String _surname;
  late String _agency;
  late String _phone;
  late String _quota;
  late String _quotaDisplay;
  @override
  void initState() {
    super.initState();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
    setState(() {
      _year = widget.year;
      _id = widget.id;
      _name = widget.name;
      _surname = widget.surname;
      _agency = widget.agency;
      _phone = widget.phone;
      _quota = widget.quota;
      if (_quota == "good_study") {
        _quotaDisplay = "เรียนดี";
      } else if (_quota == "good_person") {
        _quotaDisplay = "คนดี";
      } else if (_quota == "good_sport") {
        _quotaDisplay = "กีฬาดี";
      } else {
        _quotaDisplay = "กิจกรรมดี";
      }
    });

    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'รายละเอียดข้อมูลหลักสูตร'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                  text: const TextSpan(
                text: "รายละเอียด",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontFamily: 'PrintAble4U',
                    fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: [
                  _buildTableRow('ปีการศึกษา', _year.toString()),
                  _buildTableRow('ชื่อ', _name.toString()),
                  _buildTableRow('นามสกุล', _surname.toString()),
                  _buildTableRow('ประเภทโควตา', _quotaDisplay.toString()),
                  _buildTableRow('เบอร์โทร', _phone.toString()),
                  _buildTableRow('หน่วยงาน', _agency.toString()),
                ],
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
                            builder: (context) => EditRQPScreen(
                              id: _id,
                              agency: _agency,
                              name: _name,
                              surname: _surname,
                              phone: _phone,
                              quota: _quota,
                              year: _year,
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
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(Icons.arrow_back_ios_new_sharp),
                      const SizedBox(
                          width: 5), // Add some space between icon and text
                      const Text('กลับ'),
                    ],
                  ),
                ),
              ],
            )
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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(content),
        ),
      ),
    ]);
  }
}
