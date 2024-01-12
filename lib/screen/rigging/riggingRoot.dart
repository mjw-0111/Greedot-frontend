import 'package:flutter/material.dart';
import 'package:projectfront/widget/design/basicButtons.dart';

import 'drawSkeleton.dart';

import '../../widget/design/settingColor.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key); // Key 타입을 명시하고 super로 넘겨줍니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorMain_greedot,
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        EleButton_greedot(
            gotoScene: () => SkeletonCanvas(), buttonText: "이미지 리깅"),
        SizedBox(height: 20),
        EleButton_greedot(
            gotoScene: () => SkeletonCanvas(), buttonText: "이미지 리깅2"),
      ])),
    );
  }
}
