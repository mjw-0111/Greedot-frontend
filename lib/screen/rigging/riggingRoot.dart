import 'package:flutter/material.dart';
import 'package:projectfront/widget/design/basicButtons.dart';

import 'drawSkeleton.dart';

import '../../widget/design/settingColor.dart';
import '../../screen/root.dart';

class RootScreen extends StatelessWidget {
  final Function(String) onPageChange; // 콜백 함수를 받는 생성자 매개변수 추가

  const RootScreen({Key? key, required this.onPageChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorMainBG_greedot,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EleButton_greedot(
              additionalFunc: () => onPageChange('SkeletonCanvas'),
              buttonText: "이미지 리깅",
            ),
            const SizedBox(height: 20),
            EleButton_greedot(
              gotoScene: () => SkeletonCanvas(),
              buttonText: "이미지 리깅2",
            ),
          ],
        ),
      ),
    );
  }
}
