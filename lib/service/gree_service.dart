import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:projectfront/service/user_service.dart';
import '../constants/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:mime_type/mime_type.dart';

class ApiServiceGree {
  static Future<http.Response> uploadImage(String imagePath) async {
    final url = Uri.parse('$baseUrl/api/v1/gree/upload-raw-img');
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }

    File imageFile = File(imagePath);
    String fileName = basename(imagePath);
    String? mimeType = mime(imagePath);
    MediaType mediaType = MediaType.parse(mimeType ?? 'image/png');

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'Authorization': 'Bearer $token',
      })
      ..files.add(await http.MultipartFile.fromPath(
        'file', // 필드 이름을 'file'로 변경
        imageFile.path,
        contentType: mediaType, // contentType을 동적으로 설정
        filename: fileName,
      ));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Upload successful");
      } else {
        print("Upload failed with status: ${response.statusCode}");
      }
      return response;
    } catch (e) {
      print("Error uploading image: $e");
      rethrow;
    }
  }



  Future<void> updateGree(int greeId, Map<String, dynamic> greeUpdate) async {
    var url = '$baseUrl/api/v1/gree/update/$greeId';
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }
    var response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(greeUpdate),
    );

    if (response.statusCode == 200) {
      print('Gree updated successfully.');
    } else {
      print('Failed to update gree.');
    }
  }



  Future<List<dynamic>> readGrees() async {
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


  Future<dynamic> readGree(int greeId) async {
    var url = '$baseUrl/api/v1/gree/view/$greeId';
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load gree.');
    }
  }


  Future<void> disableGree(int greeId) async {
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
}
