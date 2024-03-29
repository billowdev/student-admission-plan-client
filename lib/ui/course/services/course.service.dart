import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project/common/constants/constants.dart';
import '../models/course.model.dart';

class CourseService {
  static Future<List<CoursePayload>> getAllCourse() async {
    final url = Uri.https(BASEURL, '$ENDPOINT/courses');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final courseModel = CourseModel.fromJson(jsonData);
      return courseModel.payload!;
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
