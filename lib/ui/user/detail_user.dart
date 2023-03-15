import 'package:flutter/material.dart';
import 'package:project/ui/course/models/course.model.dart';
import 'package:project/ui/user/models/user_model.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/appbar.widget.dart';
import '../../common/widgets/drawer.widget.dart';
import 'edit_user.dart';

class UserDetailScreen extends StatefulWidget {
  final UserPayload userPayload;
  const UserDetailScreen({super.key, required this.userPayload});
  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  // late String userPayload
  late String _id;
  late String _username;
  late String _email;
  late String _name;
  late String _surname;
  late String _phone;
  late String _role;
  late String _faculty;
  late String _createdAt;
  late String _updatedAt;

  // static String apiUrl = dotenv.env['API_URL'].toString();
  late String token = "";
  // final AuthService _authService = AuthService();
  // final TokenBloc _tokenBloc = TokenBloc(); // create an instance of TokenBloc
  @override
  void initState() {
    super.initState();

    _id = widget.userPayload.id!;
    _username = widget.userPayload.username!;
    _email = widget.userPayload.email!;
    _name = widget.userPayload.name!;
    _surname = widget.userPayload.surname!;
    _phone = widget.userPayload.phone!;
    _role = widget.userPayload.role!;
    _faculty = widget.userPayload.faculty!;
    _createdAt = widget.userPayload.createdAt!;
    _updatedAt = widget.userPayload.updatedAt!;

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
                  _buildTableRow('ชื่อผู้ใช้', _username.toString()),
                  _buildTableRow('อีเมล', _email.toString()),
                  _buildTableRow('ชื่อ', _name.toString()),
                  _buildTableRow('นามสกุล', _surname.toString()),
                  _buildTableRow('เบอร์โทร', _phone.toString()),
                  _buildTableRow('บทบาท', _role.toString()),
                  _buildTableRow('สังกัด', _faculty.toString()),
                  _buildTableRow('สร้างเมื่อ', _createdAt.toString()),
                  _buildTableRow('แก้ไขเมื่อ', _updatedAt.toString()),
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
                            builder: (context) => EditUserDetailScreen(
                                userPayload: widget.userPayload),
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
