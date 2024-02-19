import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

//값이 들어가면 register 엔드포인트로 값 전달
class ApiService {
  static Future<http.Response> registerUser(RegisterModel model) async {
    final url = Uri.parse('$baseUrl/api/v1/user/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': model.username,
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
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/user/users/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // 토큰을 Header에 추가
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  // 사용자 정보 업데이트
  static Future<http.Response> updateUser(int userId, UserUpdateModel userData) async {
    final url = Uri.parse('$baseUrl/api/v1/user/$userId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData.toJson()),
    );
    return response;
  }

  // 사용자 삭제
  static Future<http.Response> deleteUser(int userId) async {
    final url = Uri.parse('$baseUrl/api/v1/user/$userId'); // 사용자 삭제 API 엔드포인트
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  // 사용자 프로필 정보 가져오기
  static Future<UserModel> getUserProfile() async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final url = Uri.parse('$baseUrl/api/v1/user/profile');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print("Received data: ${response.body}");
      return UserModel.fromJson(json.decode(response.body));
    } else {
      // Handle non-200 responses
      throw Exception('Failed to load user profile');
    }
  }

// 사용자 프로필 정보 업데이트
  static Future<http.Response> updateUserProfile(UserProfileUpdateModel userData) async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final url = Uri.parse('$baseUrl/api/v1/user/change-profile');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(userData.toJson()),
    );
    return response;
  }

  // Chatbot 대화 업데이트 int greeId, String message
  static Future<http.Response> GetChatBotMessage(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/api/v1/ai/chat');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body:json.encode(data)
      //body: jsonEncode({'greeId':greeId,'message':message}),
    );
    return response;
  }
}

class AuthService {
  static const String tokenKey = 'auth_token';

  // 토큰 저장
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  // 토큰 가져오기
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // 토큰 삭제
  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}
