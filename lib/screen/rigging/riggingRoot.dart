import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projectfront/widget/design/basicButtons.dart';
import './drawSkeleton.dart';
import '../../widget/design/settingColor.dart';
import '../../provider/pageNavi.dart';

class RiggingRoot extends StatelessWidget {
  const RiggingRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PageNavi Provider를 가져옵니다.
    final pageNavi = Provider.of<PageNavi>(context, listen: false);

    return Container(
      color: colorMainBG_greedot,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EleButton_greedot(
              additionalFunc: () => pageNavi.changePage('SkeletonCanvas'),
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
