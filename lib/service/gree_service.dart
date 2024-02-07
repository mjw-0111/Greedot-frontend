import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../constants/constants.dart';
import '../../structure/structureInit.dart';

// class ApiServiceGree{
//     static Future<http.Response> uploadingImage(XFile image) async {
//     final url = Uri.parse('$baseUrl/api/v1/gree/upload-raw-img');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'mulitpart/form-data'},
//       body: image
//     );
//     return response;
//   }
// }

class ApiServiceGree {
  static Future<http.StreamedResponse> uploadImage(XFile image) async {
    final url = Uri.parse('$baseUrl/api/v1/gree/upload-raw-img');
    // MultipartRequest 생성
    var request = http.MultipartRequest('POST', url);

    // 파일을 MultipartFile로 변환
    var multipartFile = await http.MultipartFile.fromPath(
      'file', // 서버에서 요구하는 키 값 ('file'이라 가정)
      image.path,
    );

    // MultipartRequest에 파일 추가
    request.files.add(multipartFile);

    // 서버로 요청 보내기
    var response = await request.send();

    return response;
  }
}
