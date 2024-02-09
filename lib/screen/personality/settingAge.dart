import 'dart:math';

import 'package:flutter/material.dart';
import '../../widget/design/settingColor.dart';
import './personalitydata.dart';
import './settingMbti.dart';
import '../../structure/structure.dart';

class SettingPersonality extends StatefulWidget {
  @override
  _SettingPersonalityState createState() => _SettingPersonalityState();
}

class _SettingPersonalityState extends State<SettingPersonality> {
  int step = -1;
  double _opacity = 1.0;
  List<String?> selectedOption = List.filled(4, null);

  String? _selectedSex;
  String? _selectedAge;
  TextEditingController _nameController = TextEditingController();
  List<String> sexList = PersonalityData.sexList;
  List<String> ageList = PersonalityData.ageList;
  List<List<String>> optionValues = PersonalityData.optionValues;
  List<String> questionList = PersonalityData.questionList;
  List<List<String>> optionsList = PersonalityData.optionsList;

  void _handleRadioValueChanged(String? newValue) {
    setState(() {
      selectedOption[step] = newValue;
    });
  }

  void _goBack() {
    setState(() {
      if (step > 0) {
        step--;
      }
    });
  }
  
void _goNext() {

  setState(() {
    if (step < questionList.length - 1) {
      // 다음 질문으로 이동
      step++;
    } else {
      Gree greeInfo;
      // 모든 질문에 답함 - 결과 처리
      String MBTIResult = ''; // MBTI 결과를 계산하는 로직 추가 필요
      for (int i = 0; i < selectedOption.length; i++) {
        int index = optionsList[i].indexOf(selectedOption[i]!);
        MBTIResult += optionValues[i][index];
      }
      greeInfo = Gree(
        name: _nameController.text,
        age: _selectedAge ?? 'Nullage', // null 체크 필요
        sex: _selectedSex ?? 'Nullname', // null 체크 필요
        MBTI: MBTIResult,
      );
      _showResult = true;
      print('Name: ${greeInfo.name}, Age: ${greeInfo.age}, Sex: ${greeInfo.sex}, MBTI: ${greeInfo.MBTI}');
    }
  });
}


  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double imageSize = screenWidth * 0.3; // 이미지 너비
    double formWidth = min(screenWidth * 0.35, 500); // 폼 너비

    return Container(
      width: screenWidth,
      height: screenHeight,
      color: colorMainBG_greedot, // 전체 배경색 설정
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'assets/images/gree.png', //TODO getImage.dart 에서 이미지 받아오게 수정하기
              width: 300,
              height: 300,
            ),
            SizedBox(width: 16),
            Container(
              width: formWidth,
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (step == -1) nameGenderAge(),
                    if (step != -1 && step < questionList.length)
                      QuestionWidget(
                        step: step,
                        selectedOption: selectedOption,
                        questionList: questionList,
                        optionsList: optionsList,
                        onOptionChanged: (newValue) {
                          _handleRadioValueChanged(newValue);
                        },
                      ),
                    SizedBox(height: 60),
                    _buildNavigationButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column nameGenderAge() {
    return Column(
      children: [
        SizedBox(height: 50),
        Container(
          width: 408,
          height: 50,
          child: TextField(
            controller: _nameController,
            style: TextStyle(color: colorText_greedot),
            decoration: InputDecoration(
              labelText: '이름:',
              hintText: ' 이름을 입력하세요',
              hintStyle: TextStyle(color: colorText_greedot, fontSize: 14),
              filled: true,
              fillColor: colorBut_greedot,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorBut_greedot, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorBut_greedot, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorBut_greedot, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              labelStyle: TextStyle(color: colorText_greedot, fontSize: 14),
            ),
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                fit: FlexFit.loose,
                child:
                    _buildDropdown(sexList, _selectedSex, ' 성별: ', (newValue) {
                  setState(() {
                    _selectedSex = newValue;
                  });
                })),
            SizedBox(width: 30),
            Flexible(
                fit: FlexFit.loose,
                child:
                    _buildDropdown(ageList, _selectedAge, ' 나이: ', (newValue) {
                  setState(() {
                    _selectedAge = newValue;
                  });
})),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown(List<String> optionsList, String? selectedValue,
      String hintText, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        // 드롭다운 버튼의 배경색 설정
        fillColor: colorBut_greedot,
        filled: true,
        // 테두리 설정
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorBut_greedot, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBut_greedot, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBut_greedot, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
        // 라벨 스타일 설정
        labelStyle: TextStyle(color: colorText_greedot, fontSize: 14),
      ),
      value: selectedValue,
      hint: Text(hintText,
          style: TextStyle(color: colorText_greedot, fontSize: 14)),
      icon: const Icon(Icons.arrow_drop_down, color: colorText_greedot),
      iconSize: 20,
      elevation: 20,
      style: TextStyle(color: colorText_greedot, fontSize: 16),
      onChanged: onChanged, // 콜백 함수를 매개변수로 전달
      items: optionsList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            height: 30,
            child: Text(value, style: TextStyle(color: Colors.black)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (step > 0 && !_showResult)
            ElevatedButton(
              onPressed: _goBack,
              child: Text('이전'),
              style: ElevatedButton.styleFrom(
                primary: colorBut_greedot, // Background color
              ),
            ),
          if (step < questionList.length || _showResult)
            SizedBox(width: 20), // 버튼 사이의 간격
          ElevatedButton(
            onPressed: _goNext,
            child: Text(_showResult ? '생성완료' : '다음'),
            style: ElevatedButton.styleFrom(
              primary: colorBut_greedot, // Background color
            ),
          ),
        ],
      ),
    );
  }
}
