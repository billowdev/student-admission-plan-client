import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/auth/models/user.model.dart';
import 'package:project/ui/auth/services/auth.service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/utils/local_storage_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _handleLoginScreenState createState() => _handleLoginScreenState();
}

class _handleLoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
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

  void navigateToHomeScreen(BuildContext context, String role) {
    LocalStorageUtil.setItem('token', role);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  _handleLogin() async {
    final urlLogin = Uri.http(apiUrl, '/users/login');
    final header = {'Content-Type': 'application/json'};

    setState(() {
      _isLoading = true;
    });

    try {
      UserLogin data = await _authService.loginService(
          _usernameController.text, _passwordController.text);

      final token = data.token as String;
      final role = _getRoleFromToken(token);
      final nameUser = _getNameUserFromToken(token);

      setState(() {
        _isLoading = false;
      });

      if (token.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('เข้าสู่ระบบสำเร็จ'),
          backgroundColor: Colors.green,
        ));

        LocalStorageUtil.setItem('name-user', nameUser);
        LocalStorageUtil.setItem('token', token);

        navigateToHomeScreen(context, role);
      } else {
        showErrorMessage(context, 'เข้าสู่ระบบไม่สำเร็จ ชื่อผู้ใช้ไม่ถูกต้อง');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      showErrorMessage(context, 'ไม่สามารถเข้าสู่ระบบได้');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(txtTitle: 'หน้าเข้าสู่ระบบ'),
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
                          backgroundColor: Colors.green, // background
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
      drawer: const DrawerMenuWidget(),
    );
  }
}
