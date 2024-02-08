
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../constants/constants.dart';
import '../../structure/structureInit.dart';


import 'package:dio/dio.dart';
import 'dart:async';
import 'package:path/path.dart';



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
  static Future<Response> uploadImage(String imagePath) async {
    final url = Uri.parse('$baseUrl/api/v1/gree/upload-raw-img');
    Dio dio = Dio();

    try {
      String fileName = basename(imagePath);
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath, filename: fileName),
      });

      Response response = await dio.post(
        url.toString(),
        data: formData,
      );

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
