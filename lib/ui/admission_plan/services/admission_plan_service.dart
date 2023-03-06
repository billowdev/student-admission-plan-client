import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/admission_plan_exists_year_model.dart';

class AdmissionPlanService {
  static String baseUrl = dotenv.env['API_URL'].toString();

  void throwForStatus(int statusCode) {
    if (statusCode != 200) {
      throw Exception('Failed to load data, status code: $statusCode');
    }
  }

  Future<List<String>> getExistsYear() async {
    final url = Uri.http(baseUrl, '/admission-plans/get-exists-year');

    final response = await http.get(url);
    throwForStatus(response.statusCode);

    Map<String, dynamic> resp = jsonDecode(response.body);

    List<String> existsYear = List<String>.from(resp['payload']);
    return existsYear;
  }
}
