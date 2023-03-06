import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
