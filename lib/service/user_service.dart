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
        'username': model.username,
        'password': model.password,
      },
    );

    return response;
  }

  // 사용자 정보 가져오기
  Future<List<dynamic>> getUsers() async {
    var response = await http.get(Uri.parse('$baseUrl/api/v1/user/users/')); // 끝에 슬래시 추가
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  // 사용자 정보 업데이트
  static Future<http.Response> updateUser(int userId, UserUpdateModel userData) async {
    final url = Uri.parse('$baseUrl/api/v1/user/users/$userId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData.toJson()),
    );
    return response;
  }

  // 사용자 삭제
  static Future<http.Response> deleteUser(int userId) async {
    final url = Uri.parse('$baseUrl/api/v1/user/users/$userId'); // 사용자 삭제 API 엔드포인트
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}