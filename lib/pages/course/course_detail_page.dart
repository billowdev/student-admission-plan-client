import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/pages/course/models/course.model.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';
import 'edit_course_page.dart';

class CourseDetailScreen extends StatefulWidget {
  final CoursePayload detail;
  const CourseDetailScreen({super.key, required this.detail});
  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late String _major;
  late String _degree;
  late String _faculty;
  late String _qualification;
  static String apiUrl = dotenv.env['API_URL'].toString();

  @override
  void initState() {
    super.initState();
    _major = widget.detail.major!;
    _degree = widget.detail.degree!;
    _faculty = widget.detail.faculty!;
    _qualification = widget.detail.qualification!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(
        txtTitle: 'รายละเอียดข้อมูลหลักสูตร'
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                  text: const TextSpan(
                text: 'สาขาวิทยาการคอมพิวเตอร์',
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
                  _buildTableRow('ชื่อหลักสูตร', _major.toString()),
                  _buildTableRow('หลักสูตร', _degree.toString()),
                  _buildTableRow('คณะ', _faculty.toString()),
                  _buildTableRow('รายละเอียด', _qualification.toString()),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: const DrawerMenuWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditCourseDetailScreen(detail: widget.detail),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
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
