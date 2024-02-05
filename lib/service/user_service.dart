import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../constants/constants.dart';

//값이 들어가면 register 엔드포인트로 값 전달
class ApiService {
  static Future<http.Response> registerUser(RegisterModel model) async {
    final url = Uri.parse('$baseUrl/api/v1/user/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': model.email,
        'nickname': model.nickname,
        'password': model.password,
      }),
    );

    return response;
  }
//값이 들어가면 login 엔드포인트로 값 전달
  static Future<http.Response> loginUser(LoginModel model) async {
    final url = Uri.parse('$baseUrl/api/v1/user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'email': model.email,
        'password': model.password,
      },
    );

    return response;
  }

  Future<List<dynamic>> getUsers() async {
    var response = await http.get(Uri.parse('$baseUrl/api/v1/user/users/')); // 끝에 슬래시 추가
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

}