import 'dart:io';

import 'package:projectfront/models/user_model.dart';

import '../../widget/design/settingColor.dart';
import '../../widget/design/basicButtons.dart';
import '../../structure/structureInit.dart';
import '../../service/gree_service.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }
Future<void> showUploadSuccessSnackBar() async {
    if (_image != null) {
      final response = await ApiServiceGree.uploadImage(_image!);
      if (response.statusCode == 200) {
        // 성공적으로 업로드되었을 때의 로직
        print("업로드 성공!!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('성공적으로 업로드되었습니다'),
            duration: Duration(seconds: 2),
            backgroundColor: colorSnackBar_greedot,
          ),
        );
      } else {
        // 업로드 실패했을 때의 로직
        print("업로드 실패: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('업로드에 실패했습니다'),
            duration: Duration(seconds: 2),
            backgroundColor: colorSnackBar_greedot,
          ),
        );
      }
    } else {
      // 이미지가 선택되지 않았을 때의 로직
      print("이미지가 선택되지 않았습니다.");
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
    return Center( // Center 위젯을 사용하여 가운데로 정렬합니다.
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EleButton_greedot(
            additionalFunc: () {
              getImage(ImageSource.camera); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
            },
            buttonText: "카메라"),
        SizedBox(width: paddingForButtons),
        EleButton_greedot(
            additionalFunc: () {
              getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
            },
            buttonText: "갤러리"),
        SizedBox(width: paddingForButtons),
        EleButton_greedot(
            additionalFunc: () {
              importedImage = _image;
              showUploadSuccessSnackBar();


            },
            buttonText: "업로드"),
      ],
    );
  }
}
