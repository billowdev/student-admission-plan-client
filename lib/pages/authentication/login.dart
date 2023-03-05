import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  static String apiUrl = dotenv.env['API_URL'].toString();
  bool _isLoading = false;

  String _getRoleFromToken(String token) {
    // Parse the JWT token and retrieve the role field
    // You can use a package like jwt_decoder to parse the JWT token
    // Example code:
    final decodedToken = JwtDecoder.decode(token);
    return decodedToken['role'] as String;
  }

  _login() async {
    setState(() {
      _isLoading = true;
    });
    final urlLogin = Uri.http(apiUrl, '/users/login');
    final header = {'Content-Type': 'application/json'};

    final response = await http.post(urlLogin,
        headers: header,
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'] as String;
      final role = _getRoleFromToken(token);
      // Do something with the token, like storing it in SharedPreferences
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('เข้าสู่ระบบสำเร็จ'),
        backgroundColor: Colors.green,
      ));

      // Navigate to the home screen
      if (role == 'user') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('role', role);
        Navigator.pushReplacementNamed(context, '/home');
      } else if (role == 'admin') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('role', role);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      // Show an error message
      // ignore: use_build_context_synchronously
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

    // setState(() {
    //   _isLoading = false;
    // });
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
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
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
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
