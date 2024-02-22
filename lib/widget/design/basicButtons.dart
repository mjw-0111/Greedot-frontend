import 'package:flutter/material.dart';
import './settingColor.dart';

class EleButton_greedot extends StatelessWidget {
  final Widget Function()? gotoScene;
  final Color textColor, bgColor;
  final double width, height, fontSize;
  final EdgeInsetsGeometry padding;
  final String buttonText;
  final void Function()? additionalFunc; // nullable
  final IconData? icon; // 아이콘 추가
  final bool isSmall;

  const EleButton_greedot({
    this.width = 125,
    this.height = 45,
    this.bgColor = colorBut_greedot,
    this.textColor = Colors.white,
    required this.buttonText,
    this.fontSize = 16.0,
    this.gotoScene,
    this.padding = const EdgeInsets.symmetric(vertical: 0.2, horizontal: 0.3),
    this.additionalFunc, // nullable
    this.isSmall = false,
    this.icon, // 아이콘 추가
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 버튼 디자인을 위한 색상과 그림자 효과 정의
    final Color buttonColor = colorBut_greedot; // 예시 색상
    final double elevation = 5.0; // 그림자 높이
    final Color shadowColor = Colors.black.withOpacity(0.5); // 그림자 색상

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        foregroundColor: MaterialStateProperty.all(Colors.white), // 텍스트와 아이콘의 색을 흰색으로 설정
        minimumSize: MaterialStateProperty.all(Size(width, height)),
        padding: MaterialStateProperty.all(padding),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: fontSize)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        elevation: MaterialStateProperty.all(elevation),
        shadowColor: MaterialStateProperty.all(shadowColor),
      ),
      onPressed: () {
        additionalFunc?.call();
        if (gotoScene != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => gotoScene!()));
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: Colors.white, size: 24),
          if (icon != null) SizedBox(width: 8),
          Text(buttonText, style: TextStyle(color: textColor, fontSize: fontSize)),
        ],
      ),
    );
  }
}
