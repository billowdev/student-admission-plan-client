import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project/common/constants/constants.dart';
import 'package:project/ui/auth/models/user.model.dart';

class AuthService {
  Future<UserLogin> loginService(String username, String password) async {
    final urlLogin = Uri.http(BASEURL, '$ENDPOINT/users/login');
    final header = {'Content-Type': 'application/json'};
    final response = await http.post(urlLogin,
        headers: header,
        body: jsonEncode({
          'username': username,
          'password': password,
        }));

    if (response.statusCode == 200) {
      final res = UserLogin.fromJson(jsonDecode(response.body));

      return res;
    } else {
      return UserLogin.fromJson(jsonDecode(response.body));
    }
  }
}
