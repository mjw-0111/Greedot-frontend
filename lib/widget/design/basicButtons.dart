import 'package:flutter/material.dart';
import './settingColor.dart';

double paddingForButtons = 10;

class EleButton_greedot extends StatelessWidget {
  final Widget Function()? gotoScene;
  final Color textColor, bgColor;
  final double width, height, fontSize;
  final String buttonText;
  final void Function()? additionalFunc; //nullable

  //default value setting
  const EleButton_greedot(
      {this.width = 125,
        this.height = 50,
        this.bgColor = colorBut_greedot,
        this.textColor = colorText_greedot,
        required this.buttonText,
        this.fontSize = 16.0,
        this.gotoScene,
        this.additionalFunc, //nullable
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        fixedSize: Size(width, height),
      ),
      child: Text(buttonText, style: TextStyle(color: textColor, fontSize: fontSize)),
      onPressed: () {
        if (additionalFunc != null) {
          additionalFunc!(); // additionalFunc이 null이 아닐 때만 호출
        }
        if (gotoScene != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => gotoScene!()),
          );
        }
      },
    );
  }
}


class Big_EleButton_greedot extends StatelessWidget {
  final Widget Function()? gotoScene;
  final Color textColor, bgColor;
  final double width, height;
  final String buttonText;
  final void Function()? additionalFunc; //nullable

  //default value setting
  const Big_EleButton_greedot(
      {this.width = 160,
        this.height = 45,
        this.bgColor = colorBut_greedot,
        this.textColor = colorText_greedot,
        required this.buttonText,
        this.gotoScene,
        this.additionalFunc, //nullable
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        fixedSize: Size(width, height),
      ),
      child: Text(buttonText, style: TextStyle(color: textColor)),
      onPressed: () {
        if (additionalFunc != null) {
          additionalFunc!(); // additionalFunc이 null이 아닐 때만 호출
        }
        if (gotoScene != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => gotoScene!()),
          );
        }
      },
    );
  }
}



class Small_EleButton_greedot extends StatelessWidget {
  final double width, height, fontSize;
  final String buttonText;
  final Color bgColor, textColor;
  final Widget Function()? gotoScene;
  final void Function()? additionalFunc;

  const Small_EleButton_greedot({
    Key? key,
    this.width = 75, // 버튼의 너비
    this.height = 18, // 버튼의 높이
    this.fontSize = 12.0, // 텍스트의 폰트 사이즈
    required this.buttonText,
    this.bgColor = colorBut_greedot, // 버튼의 배경 색상
    this.textColor = colorText_greedot, // 텍스트 색상
    this.gotoScene,
    this.additionalFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        minimumSize: MaterialStateProperty.all(Size(width, height)),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 여기에 적용
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: fontSize)),
      ),
      child: Text(buttonText, style: TextStyle(color: textColor)),
      onPressed: () {
        if (additionalFunc != null) {
          additionalFunc!(); // 추가 기능이 있다면 실행
        }
        if (gotoScene != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => gotoScene!()),
          ); // gotoScene이 있다면 새 화면으로 이동
        }
      },
    );
  }
}