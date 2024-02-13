import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:projectfront/service/user_service.dart';
import '../constants/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:mime_type/mime_type.dart';
import 'package:logger/logger.dart';
import '../models/gree_model.dart';

class ApiServiceGree {
  static final Logger _logger = Logger();

  static Future<Map<String, dynamic>?> uploadImage(String imagePath) async {
    final url = Uri.parse('$baseUrl/api/v1/gree/upload-raw-img');
    final token = await AuthService.getToken();
    if (token == null) {
      _logger.e('No token found');
      return null;
    }

    File imageFile = File(imagePath);
    String fileName = basename(imagePath);
    String? mimeType = mime(imagePath);
    MediaType mediaType = MediaType.parse(mimeType ?? 'image/png');

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll({'Authorization': 'Bearer $token'})
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: mediaType,
        filename: fileName,
      ));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        _logger.i("Upload successful");
        var responseData = json.decode(response.body);
        // 전체 응답 데이터를 반환
        return responseData;
      } else {
        _logger.w("Upload failed with status: ${response.statusCode}");
        return null; // 실패 시 null 반환
      }
    } catch (e) {
      _logger.e("Error uploading image: $e");
      return null; // 예외 발생 시 null 반환
    }
  }




  static Future<void> updateGree(int greeId, GreeUpdate model) async {
    var url = '$baseUrl/api/v1/gree/update/$greeId';
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }
    var response = await http.put(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token",
        "Content-Type": "application/json"},
      body: json.encode(model.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Gree updated successfully.');
    } else {
      print('Failed to update gree. StatusCode: ${response.statusCode}, Body: ${response.body}');
    }
  }



  static Future<List<dynamic>> readGrees() async {
    var url = '$baseUrl/api/v1/gree/view';
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load grees.');
    }
  }


  static Future<dynamic> readGree(int greeId) async {
    var url = '$baseUrl/api/v1/gree/view/$greeId';
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load gree.');
    }
  }


  static Future<void> disableGree(int greeId) async {
    var url = '$baseUrl/api/v1/gree/disable/$greeId';
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }
    var response = await http.put(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Gree disabled successfully.');
    } else {
      print('Failed to disable gree.');
    }
  }

  // 이미지 처리 요청을 위한 함수
  static Future<void> processGreeImages(int greeId) async {
    final url = Uri.parse('$baseUrl/api/v1/gree/greefile/upload/$greeId');
    final token = await AuthService.getToken();
    if (token == null) {
      _logger.e('No token found');
      return;
    }

    try {
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _logger.i("Image processing successful");
        // 성공 로직, 예: 성공 알림
      } else {
        _logger.w("Image processing failed with status: ${response.statusCode}");
        // 실패 로직, 예: 실패 알림
      }
    } catch (e) {
      _logger.e("Error processing images: $e");
    }
  }
}

