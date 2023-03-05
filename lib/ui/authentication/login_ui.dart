import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/authentication/models/user.model.dart';
import 'package:project/ui/authentication/services/authentication.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _handleLoginScreenState createState() => _handleLoginScreenState();
}

class _handleLoginScreenState extends State<LoginScreen> {
  AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  static String apiUrl = dotenv.env['API_URL'].toString();
  bool _isLoading = false;

  String _getRoleFromToken(String token) {
    final decodedToken = JwtDecoder.decode(token);
    return decodedToken['role'] as String;
  }

  String _getNameUserFromToken(String token) {
    final decodedToken = JwtDecoder.decode(token);
    return decodedToken['name'] as String;
  }

  _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final urlLogin = Uri.http(apiUrl, '/users/login');
    final header = {'Content-Type': 'application/json'};
    UserLogin data = await _authService.loginService(
        _usernameController.text, _passwordController.text);
    final token = data.token as String;
    final role = _getRoleFromToken(token);
    final nameUser = _getNameUserFromToken(token);
    if (token != "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('เข้าสู่ระบบสำเร็จ'),
        backgroundColor: Colors.green,
      ));

      prefs.setString('token', token);
      prefs.setString('name-user', nameUser);
      // Navigate to the home screen
      if (role == 'user') {
        prefs.setString('role', role);
        Navigator.pushReplacementNamed(context, '/home');
      } else if (role == 'admin') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('role', role);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('เข้าสู่ระบบไม่สำเร็จ ชื่อผู้ใช้ไม่ถูกต้อง'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(txtTitle: 'หน้าเข้าสู่ระบบ'),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'ชื่อผู้ใช้',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อผู้ใช้';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'รหัสผ่าน',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกรหัสผ่าน';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // background
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _handleLogin();
                          }
                        },
                        child: const Text('เข้าสู่ระบบ',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      drawer: DrawerMenuWidget(),
    );
  }
}
