import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:projectfront/service/user_service.dart';
import '../constants/constants.dart';
import 'dart:async';



class ApiServiceGree {
  static Future<http.Response> uploadImage(String imagePath) async {
    final url = Uri.parse('$baseUrl/api/v1/gree/upload-raw-img');
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('no token');
    }

    // 파일을 준비
    File imageFile = File(imagePath);
    String fileName = basename(imagePath);

    // multipart 요청 생성
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'Authorization': 'Bearer $token',
      })
      ..files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'), // 우리 이미지 타입 넣기
        filename: fileName,
      ));

    try {
      // 요청 보내고 응답 받기
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Upload successful");
      } else {
        print("Upload failed");
      }
      return response;
    } catch (e) {
      print("Error uploading image: $e");
      rethrow;
    }
  }
}
