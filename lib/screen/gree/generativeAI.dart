import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../provider/pageNavi.dart';
import '../../service/gree_service.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class GenerativeAI extends StatefulWidget {
  final int? greeId;

  const GenerativeAI({Key? key, required this.greeId}) : super(key: key);

  @override
  _GenerativeAIState createState() => _GenerativeAIState();
}

class _GenerativeAIState extends State<GenerativeAI> {
  List<String>? uploadedImageUrls;
  int? selectedImageIndex;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  void _fetchImages() async {
    try {
      List<String> images = await ApiServiceGree.fetchUploadedImages(widget.greeId!, 1);
      setState(() {
        uploadedImageUrls = images;
        _isLoading = false; // 이미지 로딩이 완료되었으므로 로딩 상태를 false로 설정합니다.
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // 에러 발생 시에도 로딩 상태를 false로 설정하여 로딩 인디케이터를 멈춥니다.
        print("Error fetching images: $e"); // 에러 로깅
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이미지 선택하기'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: uploadedImageUrls?.length ?? 0,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: Image.network(
                    uploadedImageUrls![index], fit: BoxFit.cover),
              ),
              RadioListTile<int>(
                title: Text('선택하기'),
                value: index,
                groupValue: selectedImageIndex,
                onChanged: (int? value) {
                  setState(() {
                    selectedImageIndex = value;
                  });
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (selectedImageIndex != null) {
            final imageUrl = uploadedImageUrls![selectedImageIndex!];
            final downloadedFile = await downloadImage(imageUrl);
            if (downloadedFile != null) {
              final response = await ApiServiceGree.uploadImage(downloadedFile.path);
              if (response != null && response['message'] == 'File uploaded successfully.') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('성공적으로 업로드되었습니다'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green, // colorSnackBar_greedot 대신 사용
                  ),
                );
                final pageNavi = Provider.of<PageNavi>(context, listen: false);
                int greeId = response['gree_id'];
                  await ApiServiceGree.processGreeImages(greeId); // 추가 이미지 처리 요청
                  pageNavi.changePage('SettingPersonality', data: PageData(greeId: greeId));
              }
            }
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
  Future<File?> downloadImage(String imageUrl) async {
    try {
      // 이미지 URL에서 데이터를 가져옵니다.
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // 임시 디렉토리를 찾습니다.
        final directory = await getTemporaryDirectory();
        // 파일을 저장할 경로를 설정합니다.
        final filePath = join(directory.path, 'downloadedImage.png');
        final file = File(filePath);
        // 파일에 이미지 데이터를 씁니다.
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }
}

