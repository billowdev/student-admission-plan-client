import 'package:flutter/material.dart';
import 'package:project/ui/course/models/course.model.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';
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
  late String _detail;
  // static String apiUrl = dotenv.env['API_URL'].toString();
  late String token = "";
  // final AuthService _authService = AuthService();
  // final TokenBloc _tokenBloc = TokenBloc(); // create an instance of TokenBloc
  @override
  void initState() {
    super.initState();
    _major = widget.detail.major!;
    _degree = widget.detail.degree!;
    _faculty = widget.detail.faculty!;
    _detail = widget.detail.detail!;
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
                  _buildTableRow('ชื่อหลักสูตร', _major.toString()),
                  _buildTableRow('หลักสูตร', _degree.toString()),
                  _buildTableRow('คณะ', _faculty.toString()),
                  _buildTableRow('รายละเอียด', _detail.toString()),
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
                            builder: (context) =>
                                EditCourseDetailScreen(detail: widget.detail),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.green,
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.edit),
                          SizedBox(
                              width:
                                  5), // Add some space between icon and text
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
                    foregroundColor: Colors.white, backgroundColor: Colors.brown,
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
