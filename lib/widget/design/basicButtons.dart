import 'package:flutter/material.dart';
import './settingColor.dart';

class EleButton_greedot extends StatelessWidget {
  final Widget Function()? gotoScene;
  final Color textColor, bgColor;
  final double width, height;
  final String buttonText;
  final void Function()? additionalFunc; //nullable

  //default value setting
  const EleButton_greedot(
      {this.width = 150,
      this.height = 30,
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
          //navigation version
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => gotoScene!()),
          );
        }
      },
    );
  }
}
