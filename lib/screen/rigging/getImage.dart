import 'dart:io';

import 'package:projectfront/models/user_model.dart';
import 'package:projectfront/provider/pageNavi.dart';
import 'package:provider/provider.dart';

import '../../widget/design/settingColor.dart';
import '../../widget/design/basicButtons.dart';
import '../../structure/structureInit.dart';
import '../../service/gree_service.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../personality/settingAge.dart';

//design setting for GetImage_greedot
double paddingForButtons = 10; //다 상대적인 값으로 교체 예정
double canvasSize = 350;

class GetImage_greedot extends StatefulWidget {
  const GetImage_greedot({Key? key}) : super(key: key);
  @override
  State<GetImage_greedot> createState() => _getImageState();
}

class _getImageState extends State<GetImage_greedot> {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorMainBG_greedot,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30, width: double.infinity),
          _buildPhotoArea(),
          const SizedBox(height: 20),
          _buildButton(),
        ],
      ),
    );
  }

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(
      source: imageSource,
      maxHeight: 350,
      maxWidth: 350,
    ); //사이즈 조정이 맞는지는 모름
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }


  Future<void> showUploadSuccessSnackBar(int i) async {
    final pageNavi = Provider.of<PageNavi>(context, listen: false);
    if (_image != null) {
      final response = await ApiServiceGree.uploadImage(_imagePath!);
      if (response != null && response['message'] == 'File uploaded successfully.') {
        // 업로드 성공 로직
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('성공적으로 업로드되었습니다'),
            duration: Duration(seconds: 2),
            backgroundColor: colorSnackBar_greedot,
          ),
        );
        int greeId = response['gree_id'];
        if (i == 1){
        await ApiServiceGree.processGreeImages(greeId); // 추가 이미지 처리 요청

        pageNavi.changePage('SettingPersonality', data: PageData(greeId: greeId));
        }
        else if (i==2){
          pageNavi.changePage('GenerativeAIprompt', data: PageData(greeId: greeId,));
        }

      } else {
        // 업로드 실패 로직
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('업로드에 실패했습니다'),
            duration: Duration(seconds: 2),
            backgroundColor: colorSnackBar_greedot,
          ),
        );
      }
    } else {
      // 이미지 선택 안 됨 로직
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('업로드할 이미지를 선택해주세요.'),
          duration: Duration(seconds: 2),
          backgroundColor: colorSnackBar_greedot,
        ),
      );
    }
  }

  Widget _buildPhotoArea() {
    return Center(
      // Center 위젯을 사용하여 가운데로 정렬합니다.
      child: Container(
        width: canvasSize,
        height: canvasSize,
        decoration: _image != null
            ? BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(_image!.path)), // 이미지 파일을 화면에 띄워줍니다.
                  fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 설정합니다.
                ),
              )
            : BoxDecoration(
                color: Colors.grey, // 이미지가 없을 경우 회색 배경을 표시합니다.
              ),
      ),
    );
  }

  Widget _buildButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 첫 번째 줄에 카메라와 갤러리 버튼 배치
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EleButton_greedot(
                additionalFunc: () {
                  getImage(ImageSource.camera); // 카메라로 찍은 사진 가져오기
                },
                buttonText: "카메라"),
            SizedBox(width: paddingForButtons), // 버튼 사이의 간격 조정
            EleButton_greedot(
                additionalFunc: () {
                  getImage(ImageSource.gallery); // 갤러리에서 사진 가져오기
                },
                buttonText: "갤러리"),
          ],
        ),
        SizedBox(height: paddingForButtons),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            EleButton_greedot(
                additionalFunc: () {
                  importedImage = _image;
                  showUploadSuccessSnackBar(1); // 업로드 성공 알림 표시
                },
                buttonText: "업로드"),
            SizedBox(width: paddingForButtons),
            EleButton_greedot(
                additionalFunc: () {
                  importedImage = _image;
                  showUploadSuccessSnackBar(2); // 업로드 성공 알림 표시
                },
                buttonText: "AI 캐릭터 만들기"),
          ]
        )
      ],
    );
  }
}
