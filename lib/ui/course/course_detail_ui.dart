import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/ui/course/models/course.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';
import '../authentication/login_ui.dart';
import 'edit_course_ui.dart';

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
  late String token;
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  void initState() {
    super.initState();
    _major = widget.detail.major!;
    _degree = widget.detail.degree!;
    _faculty = widget.detail.faculty!;
    _qualification = widget.detail.qualification!;

    _getToken().then((value) => setState(() {
          token = value ?? "";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarWidget(txtTitle: 'รายละเอียดข้อมูลหลักสูตร'),
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
          if (token.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditCourseDetailScreen(detail: widget.detail),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
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
