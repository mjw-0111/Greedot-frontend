import 'package:flutter/material.dart';
import './settingColor.dart';

double paddingForButtons = 10;

class EleButton_greedot extends StatelessWidget {
  final Widget Function()? gotoScene;
  final Color textColor, bgColor;
  final double width, height, fontSize;
  final EdgeInsetsGeometry padding;
  final String buttonText;
  final void Function()? additionalFunc; //nullable
  final bool isSmall;

  //default value setting
  const EleButton_greedot(
      {this.width = 125,
        this.height = 45,
        this.bgColor = colorBut_greedot,
        this.textColor = colorBig_But_greedot,
        required this.buttonText,
        this.fontSize = 16.0,
        this.gotoScene,
        this.padding = const EdgeInsets.symmetric(vertical: 0.2, horizontal: 0.3),
        this.additionalFunc, //nullable
        this.isSmall = false,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // isSmall 플래그에 따라 버튼 크기 결정
    final double buttonWidth = isSmall ? 70 : width;
    final double buttonHeight = isSmall ? 15 : height;
    final double buttonFontSize = isSmall ? 11.0 : fontSize;
    final EdgeInsetsGeometry buttonPadding = isSmall ? EdgeInsets.zero : padding;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        minimumSize: MaterialStateProperty.all(Size(buttonWidth, buttonHeight)), // 여기를 수정
        padding: MaterialStateProperty.all(isSmall ? EdgeInsets.zero : padding),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: buttonFontSize)),
      ),
      child: Text(buttonText, style: TextStyle(color: textColor, fontSize: buttonFontSize)),
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
